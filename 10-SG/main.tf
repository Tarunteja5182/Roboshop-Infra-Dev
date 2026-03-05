module "sg"{
    count = length(var.sg_name)
    source = "../../terraform-aws-sg"
    project = local.project
    environment = local.environment
    vpc_id      = data.aws_ssm_parameter.vpc_id.value
    sg_name = var.sg_name[count.index]
}