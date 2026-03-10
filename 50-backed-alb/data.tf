data "aws_ssm_parameter" "private_subnet_ids"{
    name = "/${local.project}/${local.environment}/private_subnet_id"
}

data "aws_ssm_parameter" "backend_alb_sg_id"{
    name = "/${local.project}/${local.environment}/backend_alb"
}


