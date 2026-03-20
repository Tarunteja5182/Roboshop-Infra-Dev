resource "aws_ssm_parameter" "certificate_arn"{
    name = "/${local.project}/${local.environment}/certificate_ran"
    type = "String"
    value = aws_acm_certificate.roboshop.arn
}