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

  subscription_id = "cf73c1a7-cd17-41f6-8f16-e7fbe585e074" # Reemplaza con tu Subscription ID
 
}


