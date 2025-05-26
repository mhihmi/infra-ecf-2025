variable "db_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "The master username for the database"
  type        = string
}
