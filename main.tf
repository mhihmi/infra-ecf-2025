terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.45.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13.1"
    }
  }
  required_version = "~> 1.12.1"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "secrets_manager" {
  source      = "./modules/secrets_manager"
  db_username = var.db_username
}

# Fetch username from Secrets Manager
data "aws_secretsmanager_secret_version" "db_username" {
  secret_id  = module.secrets_manager.db_username_secret_name
  depends_on = [module.secrets_manager]
}

module "s3" {
  source = "./modules/s3"

  bucket_name  = var.bucket_name
  environment  = var.environment
  sso_role_arn = var.sso_role_arn
}

module "ec2" {
  source = "./modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  instance_name = var.instance_name
  subnet_id     = "subnet-07294a34e81639bd7" # Reference the public subnet ID from the VPC module
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"] # list required
  vpc_name            = "ecf2025-vpc"
}

data "aws_rds_engine_version" "mysql" {
  engine = "mysql"
}

module "rds" {
  source = "./modules/rds"

  allocated_storage    = 20
  engine_version       = data.aws_rds_engine_version.mysql.version # dynamically get/fetch the latest version
  instance_class       = "db.t3.micro"
  db_name              = var.db_name
  username             = data.aws_secretsmanager_secret_version.db_username.secret_string
  parameter_group_name = "default.mysql8.0"
  security_group_id    = module.vpc.mysql_security_group_id
  subnet_ids           = module.vpc.public_subnet_ids
}

output "selected_mysql_version" {
  description = "The MySQL engine version selected for the RDS instance"
  value       = data.aws_rds_engine_version.mysql.version
}