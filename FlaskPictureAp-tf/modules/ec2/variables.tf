variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}
variable "project_name" {
  type        = string
  description = "Project name - passed from the project root"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "SSH key name for the EC2 instance"
  type        = string
}

variable "my_ip" {
  description = "Your IP address for security group rules"
  type        = string
}

variable "publiq_ip" {
  description = "Publiq IP address for security group rules"
  type        = string
  default     = "194.78.13.220"