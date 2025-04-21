variable "aws_profile" {
  description = "The AWS CLI profile to use"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "The environment for the S3 bucket (e.g., dev, prod)"
  type        = string
}

variable "sso_role_arn" {
  description = "The ARN of the SSO role allowed to access the S3 bucket"
  type        = string
}