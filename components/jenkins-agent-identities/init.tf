terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.8.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azurerm" {
  features {}
  alias                           = "cft_mgmt"
  subscription_id                 = var.private_dns_subscription_id
  resource_provider_registrations = "none"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "cosmosdb"
  subscription_id            = var.cosmos_subscription_id
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "alerts-slack"
  subscription_id            = var.alerts_subscription_id
}
