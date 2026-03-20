locals{
    project = "roboshop"
    environment = "dev"
    common_tags ={
        project = "roboshop"
        env = "dev"
        terrafrom = "true"
            }
        public_subnet_ids= split(",",data.aws_ssm_parameter.public_subnet_id.value)
        frontend_alb_sg_id = data.aws_ssm_parameter.frontend_sg_id.value
        certificate_arn = data.aws_ssm_parameter.certificate_arn.value

}