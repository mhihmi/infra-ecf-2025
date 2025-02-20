terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.45.0"
    }
  }
  required_version = "~> 1.9.8"
}

variable "aws_profile" {
  description = "The AWS profile to use"
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "The AWS region to use"
  type        = string
  default     = "us-west-2"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "s3" {
  source = "./modules/s3"

  bucket_name = "ecf2025_storage"
  environment = "dev"
}
