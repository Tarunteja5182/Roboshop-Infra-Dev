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
  destination = "/tmp/bootstrap.conf"
  }

provisioner "remote-exec" {
    inline = [
               "chmod +X /tmp/bootstrap.sh",
               "sudo sh /tmp/bootstrap-cluster.sh catalogue"
    ]
  }

}


resource "aws_ec2_instance_state" "catalogue_stop" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
}

resource "aws_ami_from_instance" "example" {
  name               = "${local.project}-${local.environment}"
  source_instance_id = "aws_instace.catalogue.id"
  depends_on = [aws_ec2_instance_state.catalogue_stop]
}


resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "catalogue-${local-environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.catalogue.private_ip]
}