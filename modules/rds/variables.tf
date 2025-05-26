variable "allocated_storage" {
  description = "The allocated storage in GBs"
  type        = number
}

variable "engine_version" {
  description = "The version of the MySQL engine"
  type        = string
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "username" {
  description = "The master username for the database"
  type        = string
}

variable "password" {
  description = "The master password for the database"
  type        = string
  sensitive = true
}

variable "parameter_group_name" {
  description = "The parameter group name for the database"
  type        = string
  default     = "default.mysql8.0"
}

variable "security_group_id" {
  description = "The security group ID for the RDS instance"
  type        = string
}

variable "subnet_ids" {
  description = "The list of subnet IDs for the RDS instance"
  type        = list(string)
}