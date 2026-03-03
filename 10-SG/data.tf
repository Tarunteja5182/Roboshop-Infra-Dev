data "aws_ssm_parameter" "vpc_id" {
  name = "/${local.project}/${local.environment}/vpc_id"
}