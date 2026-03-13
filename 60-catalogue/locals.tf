locals{
    ami_id= data.aws_ami.joindevops.id
    project = "roboshop"
    environment = "dev"
    common_tags={
        project = "roboshop"
        environment = "dev"
        terraform = "true"
    }
    catalogue_sg_id= data.aws_ssm_parameter.catalogue_sg_id.value
    private_subnet_id= split("," , data.aws_ssm_parameter.private_subnet_ids.value)[0]
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    listener_arn = data.aws_ssm_parameter.listener_arn.value
}