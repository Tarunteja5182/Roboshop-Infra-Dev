data "aws_ssm_parameter" "bastion_id" {
  name = "/${local.project}/${local.environment}/bastion"
}

data "aws_ssm_parameter" "mongodb_id" {
  name = "/${local.project}/${local.environment}/mongodb"
}

data "aws_ssm_parameter" "catalogue_id" {
  name = "/${local.project}/${local.environment}/catalogue"
}

data "aws_ssm_parameter" "user_id" {
  name = "/${local.project}/${local.environment}/user"
}

data "aws_ssm_parameter" "redis_id" {
  name = "/${local.project}/${local.environment}/redis"
}


data "aws_ssm_parameter" "mysql_id" {
  name = "/${local.project}/${local.environment}/mysql"
}