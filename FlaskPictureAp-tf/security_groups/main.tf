####################### Security Groups #######################

resource "aws_security_group" "ssh" {
  name        = "${var.project_name}-${terraform.workspace}-ssh-sg"
  description = "Connect SSH to EC2"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.project_name}-${terraform.workspace}-ssh-sg" }
}

resource "aws_security_group" "lbnginx" {
  name        = "${var.project_name}-${terraform.workspace}-lbnginx-sg"
  description = "For traffic on port 80"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.project_name}-${terraform.workspace}-lbnginx-sg" }
}

resource "aws_security_group" "app" {
  name        = "${var.project_name}-${terraform.workspace}-app-sg"
  description = "Traffic for application instances"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.project_name}-${terraform.workspace}-app-sg" }
}

resource "aws_security_group" "db" {
  name        = "${var.project_name}-${terraform.workspace}-db-sg"
  description = "For database"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.project_name}-${terraform.workspace}-db-sg" }
}

resource "aws_security_group" "consul" {
  name        = "${var.project_name}-${terraform.workspace}-consul-sg"
  description = "For consul cluster"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.project_name}-${terraform.workspace}-consul-sg" }
}

resource "aws_security_group" "outbound_all" {
  name        = "${var.project_name}-${terraform.workspace}-outbound-all-sg"
  description = "Outbound traffic for all"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.project_name}-${terraform.workspace}-outbound-all-sg" }
}

####################### Rules ############################

resource "aws_vpc_security_group_egress_rule" "egress_ipv4_all" {
  security_group_id = aws_security_group.outbound_all.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Outbound traffic IPv4 for all"
  tags              = { Name = "${var.project_name}-${terraform.workspace}-egress-ipv4-all" }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_22" {
  security_group_id = aws_security_group.ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "Ingress SSH from all"
  tags              = { Name = "${var.project_name}-${terraform.workspace}-ssh-22" }
}

resource "aws_vpc_security_group_ingress_rule" "lbnginx_80" {
  security_group_id = aws_security_group.lbnginx.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Ingress HTTP from all"
  tags              = { Name = "${var.project_name}-${terraform.workspace}-nginx-80" }
}

resource "aws_vpc_security_group_ingress_rule" "app_80" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.lbnginx.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  description                  = "Allow traffic from the loadbalancer"
  tags                         = { Name = "${var.project_name}-${terraform.workspace}-app-80" }
}

resource "aws_vpc_security_group_ingress_rule" "db_tcp_5432" {
  security_group_id            = aws_security_group.db.id
  referenced_security_group_id = aws_security_group.app.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  description                  = "Allow traffic PostgreSQL from app"
  tags                         = { Name = "${var.project_name}-${terraform.workspace}-db-5432" }
}

####################### Consul #######################

locals {
  consul-port = {
    rpc      = { port = 8300, protocol = "tcp" }
    serf_tcp = { port = 8301, protocol = "tcp" }
    serf_udp = { port = 8301, protocol = "udp" }
    dns_tcp  = { port = 8600, protocol = "tcp" }
    dns_udp  = { port = 8600, protocol = "udp" }
  }
}

resource "aws_vpc_security_group_ingress_rule" "consul-port" {
  for_each = local.consul-port

  security_group_id            = aws_security_group.consul.id
  referenced_security_group_id = aws_security_group.consul.id

  from_port   = each.value.port
  to_port     = each.value.port
  ip_protocol = each.value.protocol

  description = "Consul ${each.key}"
  tags        = { Name = "${var.project_name}-${terraform.workspace}-consul-${each.key}" }
}

resource "aws_vpc_security_group_ingress_rule" "consul_tcp_8500" {
  security_group_id = aws_security_group.consul.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8500
  to_port           = 8500
  ip_protocol       = "tcp"
  description       = "Consul web UI ingress"
  tags              = { Name = "${var.project_name}-${terraform.workspace}-consul-tcp-8500" }
}
