output "database_subnet_group_name" {
  value = module.vpc.database_subnet_group_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "database_subnets" {
  value = module.vpc.database_subnets
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "default_security_group_id" {
  value = module.vpc.default_security_group_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}