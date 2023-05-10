data "azurerm_resource_group" "disks_resource_group" {
  name = "disks-${var.env}-rg"
}

data "azurerm_subnet" "postgres" {
  name                 = "postgresql"
  resource_group_name  = "cft-${var.env}-network-rg"
  virtual_network_name = "cft-${var.env}-vnet"
}

data "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  resource_group_name = "core-infra-intsvc-rg"
}