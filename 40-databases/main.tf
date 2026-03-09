resource "aws_instance" "mongo"{
    ami = local.ami_id
    instance_type = "t3.micro"
    subnet_id = local.mongo_subnet_id
    vpc_security_group_ids = [local.mongo_sg_id]
     tags = merge(local.common_tags,
  {
    Name = "${local.project}-${local.environment}-mongodb"
  } 
  )
}
resource "terraform_data" "bootstrap" {
  triggers_replace = aws_instance.mongo.id
   connection{
       type     = "ssh"
       user     = local.rm_user
       password = local.rm_pwd
       host     = aws_instance.mongo.private_ip
   }
  
  provisioner "file"{
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = ["chmod +x /tmp/bootstrap.sh",
                      "sudo sh /tmp/bootstrap.sh mongodb"]
  }
}


resource "aws_instance" "redis"{
    ami = local.ami_id
    instance_type = "t3.micro"
    subnet_id = local.mongo_subnet_id
    vpc_security_group_ids = [local.redis_sg_id]
     tags = merge(local.common_tags,
  {
    Name = "${local.project}-${local.environment}-redis"
  } 
  )
}
resource "terraform_data" "bootstrap_redis" {
  triggers_replace = aws_instance.redis.id
   connection{
       type     = "ssh"
       user     = local.rm_user
       password = local.rm_pwd
       host     = aws_instance.redis.private_ip
   }
  
  provisioner "file"{
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = ["chmod +x /tmp/bootstrap.sh",
                      "sudo sh /tmp/bootstrap.sh redis"]
  }
}