resource "tls_private_key" "azure-key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "azurerm_ssh_public_key" "bootcamp-key" {
  public_key = tls_private_key.azure-key.public_key_openssh
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  name = "bootcamp-key"
}

resource "local_file" "private_key" {
  content = tls_private_key.azure-key.private_key_pem
  filename = "bootcamp.pem"
  file_permission = "0600"
}
