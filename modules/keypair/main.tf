
#EC2 Keypair
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "key_pem" {
  content  = tls_private_key.key.private_key_pem
  filename = "${path.module}/${var.project_name}-KeyPair-${var.stage}.pem"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.project_name}-KeyPair-${var.stage}"
  public_key = tls_private_key.key.public_key_openssh
}

