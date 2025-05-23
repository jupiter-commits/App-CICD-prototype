locals {
  env_name = terraform.workspace
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "main_${locals.env_name}"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-3a"]
  public_subnets  = ["10.0.1.0/24"]
  private_subnets = []

  enable_nat_gateway           = false

  tags = {
    Environment = "main_${locals.env_name}"
  }
}



resource "aws_security_group" "public_subnet" {
  name        = "public subnet web"
  description = "Allow http, https, ssh ports for public subnets"
  vpc_id      = module.vpc.default_vpc_id

  tags = {
    Name = "public_subnet_security_group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.public_subnet.id
  cidr_ipv4         = module.vpc.default_vpc_cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.public_subnet.id
  cidr_ipv4         = module.vpc.default_vpc_cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.public_subnet.id
  cidr_ipv4         = module.vpc.default_vpc_cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_8080_ipv4" {
  security_group_id = aws_security_group.public_subnet.id
  cidr_ipv4         = module.vpc.default_vpc_cidr_block
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.public_subnet.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
