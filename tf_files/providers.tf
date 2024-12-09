terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.52.0"
    }
  }
}
provider "azurerm" {
  features {}

  subscription_id = "54d08f3c-9cef-4f2f-9d0f-bcfc30d65e6c" # Reemplaza con tu Subscription ID
 
}
