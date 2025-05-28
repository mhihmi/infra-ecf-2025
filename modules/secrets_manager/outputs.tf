output "db_username_secret_name" {
  value = aws_secretsmanager_secret.db_username.name
}