data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "disks_resource_group" {
  name = "disks-${var.env}-rg"
}

data "azuread_service_principal" "service_principal" {
  display_name = "dcd_sp_aks_dcd-cftapps-sbox_v2"
}

data "azuread_group" "dts_platform_operations" {
  display_name = "DTS Platform Operations"
}

data "azuread_group" "subiduseraccessadmin" {
  display_name = "DTS ACR Access Administrators"
}

data "azurerm_resource_group" "jenkins_key_vault_rg" {
  name = var.key_vault_rg
}

data "azurerm_resource_group" "mi" {
  name = "managed-identities-${var.env}-rg"
}

data "azurerm_resource_group" "acr_rg" {
  provider = azurerm.acr
  name     = "rpe-acr-prod-rg"
}

data "azurerm_subscription" "sub" {
  subscription_id = data.azurerm_client_config.current.subscription_id
}

data "azurerm_subnet" "postgres" {
  name                 = "postgresql"
  resource_group_name  = "cft-${var.env}-network-rg"
  virtual_network_name = "cft-${var.env}-vnet"
}