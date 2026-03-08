resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.public_subnet_id
  vpc_security_group_ids = [local.bastion_sg_id]
  iam_instance_profile = aws_iam_instance_profile.bastion_profile.name
  tags = merge(local.common_tags,
  {
    Name = "${local.project}-${local.environment}-bastion"
  } 
  )
}


resource "aws_iam_role" "bastion" {
  name = "roboshop_dev_bastion_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "roboshop-dev"
  }
}


resource "aws_iam_role_policy_attachment" "attachment" {
  role       = aws_iam_role.bastion.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${local.project}-${local.environment}-bastion"
  role = aws_iam_role.bastion.name
}