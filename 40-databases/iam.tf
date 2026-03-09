resource "aws_iam_role" "mysql" {
  name = local.iam_role_name

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

  tags = merge(local.common_tags,
    {
      Name = "${local.project}-${local.environment}-mysql"
    }
  )
  
}


resource "aws_iam_policy" "mysql" {
  name        = local.iam_policy_name
  description = "policy fir mysql ec2 to access SSM parameters"
  policy = file("policy.json")
}

resource "aws_iam_role_policy_attachment" "mysql" {
  role      = aws_iam_role.mysql.name
  policy_arn = aws_iam_policy.mysql.arn
}

resource "aws_iam_instance_profile" "mysql" {
  name = "${local.project}-${local.environment}-mysql"
  role = aws_iam_role.mysql.name
}