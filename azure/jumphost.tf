resource "azurerm_linux_virtual_machine" "jumphost" {
  name                = "bootcamp_jumphost"
  admin_username      = "ubuntu"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  computer_name       = "jumphost"

  network_interface_ids = [
    azurerm_network_interface.public-network-interface.id
  ]

  size                = "Standard_B2as_v2"

  admin_ssh_key {
    public_key = azurerm_ssh_public_key.bootcamp-key.public_key
    username   = "ubuntu"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    sku     = "server"
    offer       = "ubuntu-24_04-lts"
    version   = "latest"
  }
}