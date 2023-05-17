data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "disks_resource_group" {
  name = "disks-${var.env}-rg"
}

data "azurerm_resource_group" "jenkins_key_vault_rg" {
  name = var.key_vault_rg
}

data "azurerm_subnet" "postgres" {
  name                 = "postgresql"
  resource_group_name  = "cft-${var.env}-network-rg"
  virtual_network_name = "cft-${var.env}-vnet"
}

data "azurerm_resource_group" "mi" {
  name = "managed-identities-${var.key_vault_name}-rg"
}