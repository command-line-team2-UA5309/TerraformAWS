variable "project_name" {
  type        = string
  description = "Project name"
}
variable "env" {
  type        = string
  description = "The environment name (dev, stage, prod)"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "aws_region" {
  type = string
}