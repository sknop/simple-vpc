resource "azurerm_virtual_network" "bootcamp" {
  name = "bootcamp_vnet"

  address_space = var.vnet-cidr
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "bootcamp-public-subnet" {
  name = "bootcamp_public_subnet"

  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.bootcamp.name
  address_prefixes = var.public-subnet-cidr
}

resource "azurerm_subnet" "bootcamp-private-subnet" {
  name = "bootcamp_private_subnet"

  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.bootcamp.name
  address_prefixes = var.private-subnets-cidr
  default_outbound_access_enabled = false
}

resource "azurerm_network_security_group" "external-access" {
  name = "external_access_nsg"

  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location

  security_rule {
    name = "AllAccess"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = local.my_ip
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "public-security-group-association" {
  network_security_group_id = azurerm_network_security_group.external-access.id
  subnet_id                 = azurerm_subnet.bootcamp-public-subnet.id
}

resource "azurerm_network_interface" "public-network-interface" {
  name = "bootcamp_public_nic"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id = azurerm_subnet.bootcamp-public-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.jumphost_public_ip.id
  }
}

resource "azurerm_network_interface" "private-network-interface" {
  name = "bootcamp_private_nic"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id = azurerm_subnet.bootcamp-private-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "jumphost_public_ip" {
  name                = "jumphostPublicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

