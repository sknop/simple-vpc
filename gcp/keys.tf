resource "tls_private_key" "ssh-key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "private_key" {
  content = tls_private_key.ssh-key.private_key_pem
  filename = "bootcamp.pem"
  file_permission = "0600"
}

/*resource "local_file" "public_key" {
  content = tls_private_key.ssh-key.public_key_openssh
  filename = "bootcamp.pem"
  file_permission = "0600"
}*/


