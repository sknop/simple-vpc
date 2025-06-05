terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.31.0"
    }
    curl = {
      version = "1.0.2"
      source  = "anschoewe/curl"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

provider "curl" {
}

provider "random" {
  # Configuration options
}
