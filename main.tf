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
  public_subnet_cidr = "10.0.1.0/24"
  vpc_name          = "ecf2025-vpc"
}