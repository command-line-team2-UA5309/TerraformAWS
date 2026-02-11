variable "project_name" {
  type        = string
  description = "Project name"
}
variable "env" {
  type        = string
  description = "The environment name (e.g. dev, stage, prod)"
}
variable "security_group_ids" {
  description = "Map of security group IDs to associate with the instance"
  type        = map(string)
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "instance_type_jenkins" {
  description = "A separate, more powerful instance type for Jenkins instance"
  type        = string
}

variable "key_name" {
  description = "SSH key name for the EC2 instance"
  type        = string
}
variable "app_instance_count" {
  type        = number
  description = "Number of servers for the application"
}
