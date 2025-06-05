provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-toxic-bot-${var.environment}"
  location = var.location
}
