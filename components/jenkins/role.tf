
resource "azurerm_user_assigned_identity" "usermi" {
  resource_group_name = var.mi_rg
  location            = var.location
  name                = "jenkins-${var.key_vault_name}-mi"
  tags                = module.tags.common_tags
}

resource "azurerm_role_assignment" "miroles" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "subidcontributer" {

  for_each             = data.azurerm_client_config.current.subscription_id == "6c4d2513-a873-41b4-afdd-b05a33206631" ? local.suffix.ptl : local.suffix.ptlsbox
  scope                = "/subscriptions/${each.value}"
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "subiduseraccessadmin" {

  for_each             = data.azurerm_client_config.current.subscription_id == "6c4d2513-a873-41b4-afdd-b05a33206631" ? local.suffix.ptl : local.suffix.ptlsbox
  scope                = "/subscriptions/${each.value}"
  role_definition_name = "User Access Administrator"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "hmctsacrpull" {
  scope                = data.azurerm_resource_group.acr_rg.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}
