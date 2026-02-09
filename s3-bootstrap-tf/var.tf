variable "aws_region" {
  description = "AWS region for the resourc"
  type        = string
}
variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resourc"
  type        = map(string)
  default = {
    Environment = "Development"
    ManagedBy   = "Terraform"
    Project     = "Flask-App"
  }
}