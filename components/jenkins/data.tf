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

data "azuread_group" "dts_operations" {
  for_each         = { for k, v in var.operations_groups : k => v }
  display_name     = "DTS Operations (env:${each.value})"
  security_enabled = true
}

data "azurerm_user_assigned_identity" "monitoring_mi" {
  for_each            = local.included_environments
  provider            = azurerm.managed_identity_infra_subs
  name                = "monitoring-${each.key}-mi"
  resource_group_name = data.azurerm_resource_group.managed_identities[each.key].name
}

data "azurerm_resource_group" "managed_identities" {
  for_each = toset(local.all_environments)
  provider = azurerm.managed_identity_infra_subs
  name     = "managed-identities-${each.value}-rg"
}

data "azuread_service_principals" "pipeline" {
  display_names = [
    "DTS Bootstrap (sub:dcd-cftapps-dev)",
    "DTS Bootstrap (sub:dcd-cftapps-ithc)",
    "DTS Bootstrap (sub:dcd-cftapps-demo)",
    "DTS Bootstrap (sub:dcd-cftapps-stg)",
    "DTS Bootstrap (sub:dcd-cftapps-test)",
    "DTS Bootstrap (sub:dcd-cftapps-prod)",
  ]
}
