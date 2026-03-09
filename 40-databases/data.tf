data "aws_ami" "joindevops" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "database_subnet_id"{
    name = "/${local.project}/${local.environment}/database_subnet_id"
}

data "aws_ssm_parameter" "mongo_sg_id"{
    name= "/${local.project}/${local.environment}/mongodb"
}

data "aws_ssm_parameter" "redis_sg_id"{
    name= "/${local.project}/${local.environment}/redis"
}

data "aws_ssm_parameter" "mysql_sg_id"{
    name= "/${local.project}/${local.environment}/mysql"
}

data "aws_ssm_parameter" "rabbitmq_sg_id"{
    name= "/${local.project}/${local.environment}/rabbitmq"
}