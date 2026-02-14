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

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
variable "instance_type_jenkins" {
  description = "A separate, more powerful instance type for Jenkins instance"
  type        = string
}
variable "app_instance_count" {
  type        = number
  description = "Number of servers for the application"
}
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

