provider "aws" {
  region = var.aws_region
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

module "security" {
  source       = "./security_groups"
  vpc_id       = aws_default_vpc.default.id
  project_name = var.project_name
}
