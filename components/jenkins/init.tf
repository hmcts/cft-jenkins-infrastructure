terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.94.0"
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
  features {}
  alias           = "private_endpoint"
  subscription_id = var.subscription_id
}

provider "azurerm" {
  alias                      = "managed_identity_infra_subs"
  subscription_id            = local.mi_cft[local.mi_environment].subscription_id
  skip_provider_registration = "true"
  features {}
}

