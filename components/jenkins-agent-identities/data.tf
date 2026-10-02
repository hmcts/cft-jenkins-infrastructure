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

data "azurerm_subscription" "current" {}

data "azuread_group" "aks_administrators" {
  display_name     = "DTS AKS Administrators (sub:${lower(data.azurerm_subscription.current.display_name)})"
  security_enabled = true
}

data "azurerm_monitor_action_group" "slack_alerts" {
  provider            = azurerm.alerts-slack
  resource_group_name = "cft-alerts-slack-ptl"
  name                = "cft-alerts-slack-warning-alerts"
}

data "azurerm_key_vault" "cftptl_vault" {
  count               = var.env == "prod" ? 1 : 0
  provider            = azurerm.cft-ptl
  name                = "cftptl-intsvc"
  resource_group_name = "core-infra-intsvc-rg"
}

data "azurerm_role_definition" "rbac_admin_role" {
  for_each = toset(var.rbac_admin_roles)

  name  = each.value
  scope = "/subscriptions/${var.subscription_id}"
}
