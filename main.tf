terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.45.0"
    }
  }
  required_version = "~> 1.11.4"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

data "aws_rds_engine_version" "mysql" {
  engine = "mysql"
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  environment = var.environment
  sso_role_arn = var.sso_role_arn
}

module "ec2" {
  source = "./modules/ec2"

  ami_id         = var.ami_id
  instance_type  = var.instance_type
  key_name       = var.key_name
  instance_name  = var.instance_name
  subnet_id      = "subnet-07294a34e81639bd7" # Reference the public subnet ID from the VPC module
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr          = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"] # list required
  vpc_name          = "ecf2025-vpc"
}

module "rds" {
  source = "./modules/rds"

  allocated_storage    = 20
  engine_version       = data.aws_rds_engine_version.mysql.version # dynamically get/fetch the latest version
  instance_class       = "db.t3.micro"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  security_group_id    = module.vpc.mysql_security_group_id
  subnet_ids           = module.vpc.public_subnet_ids
}

output "selected_mysql_version" {
  description = "The MySQL engine version selected for the RDS instance"
  value       = data.aws_rds_engine_version.mysql.version
}