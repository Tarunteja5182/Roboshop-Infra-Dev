variable "sg_name"{
    type = list
    default = ["mongodb","redis","mysql","rabbitmq",
               "catalogue","cart","user","payment","shipping",
               "frontend",
               "frontend_alb",
               "backend_alb",
               "bastion"]
}