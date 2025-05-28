output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.mysql.endpoint
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.mysql.id
}

output "master_user_secret_arn" {
  value = aws_db_instance.mysql.master_user_secret[0].secret_arn
}