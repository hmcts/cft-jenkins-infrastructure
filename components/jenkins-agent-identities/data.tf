data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "infra_vault" {
  for_each            = var.key_vaults
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

data "azuread_group" "directory_readers" {
  display_name     = "DTS Directory Readers"
  security_enabled = true
}

data "azurerm_resource_group" "slack_alerts" {
  provider = azurerm.alerts-slack
  name     = "cft-alerts-slack-ptl"
}
