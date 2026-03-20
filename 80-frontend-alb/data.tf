data "aws_ssm_parameter" "public_subnet_id"{
    name = "/${local.project}/${local.environment}/Public_subnet_id"
}

data "aws_ssm_parameter" "frontend_sg_id"{
    name = "/${local.project}/${local.environment}/frontend_alb"
}

data "aws_ssm_parameter" "certificate_arn"{
    name = "/${local.project}/${local.environment}/certificate_ran"
}

