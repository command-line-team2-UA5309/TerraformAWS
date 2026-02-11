locals {
  project_name = var.project_name
  
  common_tags = {
    Project     = local.project_name
    Environment = var.env
    ManagedBy   = "Terraform"
  }
 
}