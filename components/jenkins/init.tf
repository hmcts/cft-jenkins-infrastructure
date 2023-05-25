terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.54.0"
    }
  }
  required_version = "1.4.6"
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "postgres_network"
  subscription_id            = var.subscription_id
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "cosmosdb"
  subscription_id            = var.cosmos_subscription_id
}

provider "azurerm" {
  subscription_id = "8999dec3-0104-4a27-94ee-6588559729d1"
  alias           = "acr"
  features {}
}