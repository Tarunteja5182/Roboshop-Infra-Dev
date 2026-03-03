module "sg"{
    source = "../../terraform-aws-sg"
    project = local.project
    environment = local.environment
    vpc_id      = data.aws_ssm_parameter.vpc_id.value
}