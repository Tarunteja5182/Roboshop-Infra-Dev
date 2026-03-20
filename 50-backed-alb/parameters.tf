resource "aws_ssm_parameter" "listener_arn"{
    name = "/${local.project}/${local.environment}/backend_listener_arn"
    type= "String" 
    value = aws_lb_listener.http.arn
}
