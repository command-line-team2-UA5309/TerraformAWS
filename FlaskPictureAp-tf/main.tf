resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

module "security" {
  source       = "./modules/security_groups"
  vpc_id       = aws_default_vpc.default.id
  project_name = local.project_name
  env          = var.env
}
