locals{
    common_tags = {
        project = "roboshop"
        environment = "dev"
    }
    ami_id = data.aws_ami.joindevops.id
    project = "roboshop"
    environment = "dev"
    bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
    public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]

}