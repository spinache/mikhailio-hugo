provider "azurerm" {
}

provider "random" {
}

resource "azurerm_resource_group" "rg" {
  name     = "terraform-workshop"
  location = "westus"
}

resource "random_string" "sa_name" {
  length = 10
  special = false
  upper = false
}

resource "azurerm_storage_account" "sa" {
  name                     = "sa${random_string.sa_name.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}