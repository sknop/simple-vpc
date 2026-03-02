provider "aws" {
  region = var.region
}


#################################################################
# Availability Zones
#################################################################

data "aws_availability_zones" "available" {
  # Exclude local zones
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  len      = length(data.aws_availability_zones.available.names)
  azs      = slice(data.aws_availability_zones.available.names, local.len - 3, local.len)

  tags = {
    cflt_environment  = var.cflt_environment
    cflt_partition    = var.cflt_partition
    cflt_managed_by	  = var.cflt_managed_by
    cflt_managed_id	  = var.cflt_managed_id
    cflt_service      = var.cflt_service
    cflt_environment  = var.cflt_environment
    cflt_keep_until   = local.keep_until_date
  }
}

################################################################################
# VPC
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "simple-vpc"
  cidr = var.vpc-cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc-cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc-cidr, 8, k + 48)]
  intra_subnets   = [for k, v in local.azs : cidrsubnet(var.vpc-cidr, 8, k + 52)]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = local.tags
}


resource "aws_security_group" "all-bootcamp" {
  name = "all-bootcamp-sg"
  description = "Allows free traffic between all instances within the bootcamp VPC"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow all access within the bootcamp"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.vpc-cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bootcamp Internal Access"
    owner_email = var.owner_email
    owner_name = var.owner_name
  }
}

resource "aws_security_group" "external-access" {
  name = "external-access-sg"
  description = "Allows free traffic from a specific IP"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow all access from a specific host"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [local.my_ip]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bootcamp External Access"
    owner_email = var.owner_email
    owner_name = var.owner_name
  }
}
