resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id  # Reference the public subnet ID from the VPC module

  user_data = file("${path.module}/../../scripts/install_tomcat.sh") # ${path.module} ensures the path is relative to the module's location.

  tags = {
    Name = var.instance_name
  }
}