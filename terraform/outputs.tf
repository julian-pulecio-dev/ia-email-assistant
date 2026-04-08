output "public_subnets" {
  value = module.vpc.subnet_ids
}

output "ecs_security_group" {
  value = module.vpc.security_group_id
}

output "rds_database" {
  value = module.rds.database_host
}