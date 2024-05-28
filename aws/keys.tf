resource "tls_private_key" "aws-key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "bootcamp-key" {
  key_name = var.bootcamp-key-name
  public_key = tls_private_key.aws-key.public_key_openssh
}

resource "local_file" "private_key" {
  content = tls_private_key.aws-key.private_key_pem
  filename = "bootcamp.pem"
  file_permission = "0600"
}
