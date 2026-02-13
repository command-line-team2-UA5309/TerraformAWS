resource "aws_key_pair" "bird_key" {
  key_name   = "${var.project_name}-${var.env}-key"
  public_key = file("~/.ssh/command_key.pub")
}
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
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
  vpc_id       = aws_default_vpc.default.id
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
