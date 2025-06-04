output "jumphost_public_ip" {
  value = azurerm_linux_virtual_machine.jumphost.public_ip_address
  description = "The public IP address of the Jumphost instance"
}

output "bootcamp_key_location" {
  value = local_file.private_key.filename
}