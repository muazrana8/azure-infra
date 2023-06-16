terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "your_storage_account_name"
    container_name       = "your_container_name"
    key                  = "your_state_file_name.tfstate"
    access_key           = "your_storage_account_access_key"
  }
}

provider "azurerm" {
  features {}
}

module "azure_infra" {
  source  = "./modules/azure_infra"

  resource_group_name = "my-resource-group"
  location            = "West Europe"
  virtual_network_cidr = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.2.0/24"
}
