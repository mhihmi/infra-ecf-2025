output "db_username_secret_name" {
  value = aws_secretsmanager_secret.db_username.name
}
output "db_password_secret_name" {
  value = aws_secretsmanager_secret.db_password.name
}