locals{
    ami_id= data.aws_ami.joindevops.id
    project = "roboshop"
    environment = "dev"
    common_tags={
        project = "roboshop"
        environment = "dev"
        terraform = "true"
    }
    subnet_ids= aws_ssm_parameter.catalogue_sg_id.value
    private_subnet_id= split("," , aws_ssm_parameter.private_subnet_ids.value)
}