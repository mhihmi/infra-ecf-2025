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
}
