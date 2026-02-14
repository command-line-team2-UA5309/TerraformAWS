resource "aws_key_pair" "bird_key" {
  key_name = "${var.project_name}-${var.env}-key"
  # Insert the path to your public key here
  public_key = file("~/.ssh/command_key.pub")
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

####### module "vpc" ##########
module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  env          = var.env
  vpc_cidr     = var.vpc_cidr
  aws_region   = var.aws_region
}

####### module "security_groups" #########
module "security_groups" {
  source       = "./modules/security_groups"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  env          = var.env
}

####### module "ec2" #########
module "ec2" {
  source            = "./modules/ec2"
  key_name          = aws_key_pair.bird_key.key_name
  project_name      = var.project_name
  env               = var.env
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  security_group_ids = {
    ssh      = module.security_groups.ssh_sg_id
    db       = module.security_groups.db_sg_id
    lb       = module.security_groups.lbnginx_sg_id
    app      = module.security_groups.app_sg_id
    consul   = module.security_groups.consul_sg_id
    outbound = module.security_groups.outbound_all_sg_id
  }
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  instance_type_jenkins = var.instance_type_jenkins
  app_instance_count    = var.app_instance_count

}

####### S3 for DB and S3 for imeges #########
module "S3_images" {
  source                    = "./modules/S3"
  bucket_name               = "${var.project_name}-${var.env}-images-${random_id.bucket_suffix.hex}"
  iam_instance_profile_name = aws_iam_instance_profile.app_profile.name
}

module "S3_reports" {
  source            = "./modules/S3"
  bucket_name       = "${var.project_name}-${var.env}-reports-${random_id.bucket_suffix.hex}"
  versioning_status = "Enabled"
}
