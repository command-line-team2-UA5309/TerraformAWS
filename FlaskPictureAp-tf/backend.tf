terraform {
  backend "s3" {
    bucket = "s3-project-flask-picture-app-bird-terraform-state"
    key    = "state/terraform.tfstate"
    region = "eu-north-1"
  }
}
