resource "random_pet" "suffix" {
  length = 2
}

resource "time_static" "now" {}

# Change secret name to include different prefix and a timestamp on each apply
locals {
  secret_name_prefix = "yourmediadb/mysql/${random_pet.suffix.id}-${time_static.now.unix}"
  db_username_secret_name = "${local.secret_name_prefix}-username"
}

resource "aws_secretsmanager_secret" "db_username" {
  name = local.db_username_secret_name 
}

resource "aws_secretsmanager_secret_version" "db_username_version" {
  secret_id     = aws_secretsmanager_secret.db_username.id
  secret_string = var.db_username
}