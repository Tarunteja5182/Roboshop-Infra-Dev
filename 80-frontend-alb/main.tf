resource "aws_lb" "frontend" {
  name               = "${local.project}-${local.environment}-frontend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.frontend_alb_sg_id]
  subnets            = local.public_subnet_ids

  enable_deletion_protection = false

  tags = merge(
    {
        Name = "${local.project}-${local.environment}-frontend-alb"
    },
    local.common_tags
  )
  
}


resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.frontend.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = local.certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hi from frontend alb </h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "roboshop" {
  zone_id = var.zone_id
  name    = "*.${var.domain_name}"
  type    = "A"
   
   alias {
    name                   = aws_lb.frontend.dns_name
    zone_id                = aws_lb.frontend.zone_id
    evaluate_target_health = true
  }
  allow_overwrite = true
}