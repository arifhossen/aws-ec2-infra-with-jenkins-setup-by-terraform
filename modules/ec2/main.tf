# Jenkins EC2 Instance
resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = element(var.subnet_ids, 0)               # Assigning the first public subnet
  vpc_security_group_ids = [var.security_group_id]                  # Use security group IDs instead of names
  user_data              = filebase64("${path.module}/userdata.sh") # User data script for instance initialization

  tags = {
    Name = "${var.project_name}-${var.stage}"
  }

}
