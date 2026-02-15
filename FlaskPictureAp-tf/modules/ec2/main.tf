####################### Jenkins #######################
resource "aws_instance" "jenkins" {
  ami           = var.ami_id
  instance_type = var.instance_type_jenkins
  key_name      = var.key_name

  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true

  vpc_security_group_ids = [
    var.security_group_ids["ssh"],
    var.security_group_ids["outbound"]
  ]
  tags = {
    Name        = "${var.project_name}-${var.env}-jenkins"
    Environment = var.env
    Project     = var.project_name
    Role        = "jenkins"
    ManagedBy   = "Terraform"
  }
}
####################### Database #######################
resource "aws_instance" "db" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false

  vpc_security_group_ids = [
    var.security_group_ids["ssh"],
    var.security_group_ids["db"],
    var.security_group_ids["outbound"]
  ]

  tags = {
    Name        = "${var.project_name}-${var.env}-db"
    Environment = var.env
    Project     = var.project_name
    Role        = "db"
    ManagedBy   = "Terraform"
  }
}

####################### LoadBalancer (Nginx) #######################
resource "aws_instance" "lb" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true


  vpc_security_group_ids = [
    var.security_group_ids["ssh"],
    var.security_group_ids["lb"],
    var.security_group_ids["outbound"]
  ]

  tags = {
    Name        = "${var.project_name}-${var.env}-lb"
    Environment = var.env
    Project     = var.project_name
    Role        = "lb"

    ManagedBy = "Terraform"
  }
}

####################### Application Servers #######################
resource "aws_instance" "app" {
  count         = var.app_instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false

  vpc_security_group_ids = [
    var.security_group_ids["ssh"],
    var.security_group_ids["app"],
    var.security_group_ids["outbound"]
  ]

  iam_instance_profile = var.iam_instance_profile_name
  tags = {
    Name        = "${var.project_name}-${var.env}-app-${count.index + 1}"
    Environment = var.env
    Project     = var.project_name
    Role        = "app"

    ManagedBy = "Terraform"
  }
}

####################### Consul #######################
resource "aws_instance" "consul" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false

  vpc_security_group_ids = [
    var.security_group_ids["ssh"],
    var.security_group_ids["consul"],
    var.security_group_ids["outbound"]
  ]

  tags = {
    Name        = "${var.project_name}-${var.env}-consul"
    Environment = var.env
    Project     = var.project_name
    Role        = "consul"
    ManagedBy   = "Terraform"
  }
}
