variable "aws_region" {
  type = string
}
variable "env" {
  type        = string
  description = "The environment name (e.g. dev, stage, prod)"
}
variable "project_name" {
  type        = string
  description = "The name of project"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where resources will be created"
}