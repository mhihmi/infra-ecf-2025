output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public[*].id # output all subnet IDs or public[0] first one
}

output "mysql_security_group_id" {
  description = "The ID of the MySQL security group"
  value       = aws_security_group.mysql.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public[*].id
}