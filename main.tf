provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg1" {
  name     = "rg1"
  location = "West Europe"
}

resource "azurerm_virtual_network" "development-vpc" {
  name                = "development-vpc"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = [var.vnet_cidr_block]

    tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "dev-subnet-1" {
  name                 = "sub1"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.development-vpc.name
  address_prefixes     = [var.subnet_cidr_block]
  default = "10.0.10.0/24"
 }

 output "dev-vpc-id" {
    value = azurerm_virtual_network.development-vpc.id

 }

 output "dev-subnet-id"{
    value = azurerm_subnet.dev-subnet-1.id
 }










