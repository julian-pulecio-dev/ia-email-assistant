data "aws_secretsmanager_secret" "db_password" {
  name = var.db_password_secret_name
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}

data "aws_secretsmanager_secret" "db_user" {
  name = var.db_user_secret_name
}

data "aws_secretsmanager_secret_version" "db_user" {
  secret_id = data.aws_secretsmanager_secret.db_user.id
}

module "vpc" {
  source = "./modules/vpc"
  name = "${var.name}-vpc"
}

module "rds" {
  source = "./modules/rds"
  vpc_id = module.vpc.vpc_id
  db_name     = var.db_name
  db_user     = data.aws_secretsmanager_secret_version.db_user.secret_string
  db_password = data.aws_secretsmanager_secret_version.db_password.secret_string
  subnet_group_name = module.vpc.subnet_group_name
  allowed_security_group_ids = [module.vpc.security_group_id]
}