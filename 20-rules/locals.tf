locals{
    project = "roboshop"
    environment = "dev"
    bastion_sg_id= data.aws_ssm_parameter.bastion_id.value
    mongo_sg_id= data.aws_ssm_parameter.mongodb_id.value
    catalogue_sg_id= data.aws_ssm_parameter.catalogue_id.value
    user_sg_id= data.aws_ssm_parameter.user_id.value
    redis_sg_id= data.aws_ssm_parameter.redis_id.value
    mysql_sg_id= data.aws_ssm_parameter.mysql_id.value
    rabbitmq_sg_id= data.aws_ssm_parameter.rabbitmq_id.value
    backend_alb_sg_id= data.aws_ssm_parameter.backend_alb_id.value
    frontend_alb_sg_id= data.aws_ssm_parameter.frontend_alb_id.value
    frontend_sg_id= data.aws_ssm_parameter.frontend_id.value
    cart_sg_id = data.aws_ssm_parameter.cart_id.value
    shipping_sg_id = data.aws_ssm_parameter.shipping_id.value
    payment_sg_id = data.aws_ssm_parameter.payment_id.value
}