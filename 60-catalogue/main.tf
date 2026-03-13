resource "aws_instance" "catalogue"{
    ami = local.ami_id
    instance_type = "t3.micro"
    subnet_id = local.private_subnet_id
    vpc_security_group_ids=[local.catalogue_sg_id]

    tags = merge(local.common_tags,{
        Name = "${local.project}-${local.environment}-catalogue"
    }
    )
}

resource "terraform_data" "bootstrap_catalogue"{
    triggers_replace = aws_instance.catalogue.id

   connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }
  
  provisioner "file" {
  source      = "bootstrap.sh"
  destination = "/tmp/bootstrap.sh"
  }

provisioner "remote-exec" {
    inline = [
               "chmod +X /tmp/bootstrap.sh",
               "sudo sh /tmp/bootstrap.sh catalogue"
    ]
  }

}


resource "aws_ec2_instance_state" "catalogue_stop" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [terraform_data.bootstrap_catalogue]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${local.project}-${local.environment}"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [aws_ec2_instance_state.catalogue_stop]
}


resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "catalogue-${local.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.catalogue.private_ip]
}

resource "aws_lb_target_group" "catalogue" {
  name     = "${local.project}-${local.environment}-catalogue"
  port     = 8080
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = local.vpc_id
  deregistration_delay = 60

  health_check{
    healthy_threshold = 2
    interval = 20
    path = "/health"
    matcher = "200-299"
    protocol = "HTTP"
    port = 8080
    timeout =5
    unhealthy_threshold = 2 
  }
}

resource "aws_launch_template" "catalogue" {
  name = "${local.project}-${local.environment}-catalogue"

  image_id = aws_ami_from_instance.catalogue.id

  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  update_default_version = true

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      {
      Name = "${local.project}-${local.environment}-catalogue"
      },
      local.common_tags)
  }
  tag_specifications {
    resource_type = "volume"

    tags = merge(
      {
      Name = "${local.project}-${local.environment}-catalogue"
      },
      local.common_tags)
  }
  tags = merge(
      {
      Name = "${local.project}-${local.environment}-catalogue"
      },
      local.common_tags)
}

resource "aws_autoscaling_group" "catalogue" {
  name                      = "${local.project}-${local.environment}-catalogue"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 120
  health_check_type         = "ELB"
  desired_capacity          = 1

  vpc_zone_identifier       = [local.private_subnet_id]
  target_group_arns         = [aws_lb_target_group.catalogue.arn]
  
  launch_template {
    id      = aws_launch_template.catalogue.id
    version = "$latest"
  }

   instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

timeouts {
    delete = "15m"
  }

  dynamic tag{
   for_each = merge(
      {
      Name = "${local.project}-${local.environment}-catalogue"
      },
      local.common_tags)
                
     content{
        key                 = tag.key
        value               = tag.value
        propagate_at_launch = true
    }           
  }
  tag {
    key                 = "Name"
    value               = "${local.project}-${local.environment}-catalogue"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_policy" "catalogue" {
  name                   = "${local.project}-${local.environment}-catalogue"
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  policy_type            = "TargetTrackingScaling"

 target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }

}


resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = local.listener_arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  condition {
    host_header {
      values = ["catalogue.backend_alb-${local.environment}.${var.domain_name}"]
    }
  }
}

resource "terraform_data" "catalogue_delete"{
  depends_on = [aws_autoscaling_policy.catalogue]
  provisioner "local-exec" {
      command = "aws ec2 terminate-instances – instance-ids ${aws_instance.catalogue.id}"
  }
}