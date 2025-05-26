resource "aws_secretsmanager_secret" "db_password" {
  name = "yourmedia/mysql/password"
}

resource "aws_secretsmanager_secret_version" "db_password_version" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = var.db_password
}

resource "aws_secretsmanager_secret" "db_username" {
  name = "yourmedia/mysql/username"
}

resource "aws_secretsmanager_secret_version" "db_username_version" {
  secret_id     = aws_secretsmanager_secret.db_username.id
  secret_string = var.db_username
}