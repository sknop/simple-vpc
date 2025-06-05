output "resource-group-name" {
  value = azurerm_resource_group.rg.name
  description = "Name of the (randomised) resource group"
}

output "jumphost_public_ip" {
  value = azurerm_linux_virtual_machine.jumphost.public_ip_address
  description = "The public IP address of the Jumphost instance"
}

output "bootcamp_key_location" {
  value = local_file.private_key.filename
}

