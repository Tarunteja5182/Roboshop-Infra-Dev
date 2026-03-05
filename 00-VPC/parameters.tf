resource "aws_ssm_parameter" "vpc-id" {
  name  = "/${local.project}/${local.environment}/vpc_id"
  type  = "String"
  value = module.mod_vpc.vpc_id
}


resource "aws_ssm_parameter" "public_subnet_id" {
  name  = "/${local.project}/${local.environment}/Public_subnet_id"
  type  = "StringList"
  value = join(",",module.mod_vpc.public_subnet_id)
}

resource "aws_ssm_parameter" "Private_subnet_id"{
  name = "/${local.project}/${local.environment}/private_subnet_id"
  type = "StringList"
  value = join(",",module.mod_vpc.private_subnet_id)
}

resource "aws_ssm_parameter" "database_subnet_id"{
  name = "/${local.project}/${local.environment}/database_subnet_id"
  type = "StringList"
  value = join(",",module.mod_vpc.database_subnet_id)
}