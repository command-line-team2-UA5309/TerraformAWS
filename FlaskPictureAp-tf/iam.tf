resource "aws_iam_policy" "s3_access" {
  name        = "${var.project_name}-${var.env}-s3-access-policy"
  description = "S3 access policy for ${var.project_name} - ${var.env} "

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:PutObject", "s3:GetObject", "s3:ListBucket", "s3:DeleteObject"]
      Resource = [
        "arn:aws:s3:::${var.project_name}-${var.env}-*",
        "arn:aws:s3:::${var.project_name}-${var.env}-*/*"
      ]
    }]
  })
}

resource "aws_iam_role" "app_role" {
  name = "${var.project_name}-${var.env}-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "app_s3_attach" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}

resource "aws_iam_instance_profile" "app_profile" {
  name = "${var.project_name}-${var.env}-app-instance-profile"
  role = aws_iam_role.app_role.name
}