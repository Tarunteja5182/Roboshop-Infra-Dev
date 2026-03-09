resource "aws_route53_record" "mongodb" {
  zone_id = var.zoneid
  name    = "mongodb-${local.environment}.${var.domain_name}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.mongo.private_ip]
}

resource "aws_route53_record" "redis" {
  zone_id = var.zoneid
  name    = "redis-${local.environment}.${var.domain_name}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.redis.private_ip]
}

resource "aws_route53_record" "mysql" {
  zone_id = var.zoneid
  name    = "mysql-${local.environment}.${var.domain_name}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.mysql.private_ip]
}

resource "aws_route53_record" "rabbitmq" {
  zone_id = var.zoneid
  name    = "rabbitmq-${local.environment}.${var.domain_name}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.rabbitmq.private_ip]
}