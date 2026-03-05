resource "aws_ssm_parameter" "sg_id" {
  name  = "/${local.project}/${local.environment}/sg_id"
  type  = "String"
  value = module.sg.sg_id
}