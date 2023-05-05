module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = var.name
  cidr = "10.1.0.0/16"

  azs              = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnets   = ["10.1.11.0/24", "10.1.12.0/24", "10.1.13.0/24"]
  database_subnets = ["10.1.21.0/24", "10.1.22.0/24", "10.1.23.0/24"]

  create_igw             = true
  enable_nat_gateway     = true
  enable_vpn_gateway     = false
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  manage_default_security_group  = var.manage_default_security_group
  default_security_group_ingress = var.default_security_group_ingress

  # RDS
  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true
  enable_dns_support                     = true
  enable_dns_hostnames                   = true

  tags = var.tags
}