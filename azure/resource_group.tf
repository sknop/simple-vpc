# A resource group is like a folder for related resources. You can delete the resource group to delete all resources in it.
resource "random_pet" "resource-group" {

}

resource "azurerm_resource_group" "rg" {
  name     = "cc-bootcamp-${random_pet.resource-group.id}"
  location = var.location
}

