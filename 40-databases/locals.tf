locals{
    ami_id= data.aws_ami.joindevops.id
    project = "roboshop"
    environment = "dev"
    mongo_subnet_id = split(",",data.aws_ssm_parameter.mongo_subnet_id)[0]
    mongo_sg_id = data.aws_ssm_parameter.mongo_sg_id.value
    rm_user= "ec2-user"
    rm_pwd="DevOps321"
    common_tags ={
        project = "roboshop"
        terraform = "true"
        environment = "dev"
    }
}