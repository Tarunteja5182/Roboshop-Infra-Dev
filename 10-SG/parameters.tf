/* resource "aws_ssm_parameter" "sg_id" {
  name  = "/${local.project}/${local.environment}/sg_id"
  type  = "String"
  value = module.sg.sg_id
} */


resource "aws_ssm_parameter" "sg_id" {
  count = length(var.sg_name)  
  name  = "/${local.project}/${local.environment}/${var.sg_name[count.index]}"
  type  = "String"
  value = module.sg[count.index].sg_id
} 