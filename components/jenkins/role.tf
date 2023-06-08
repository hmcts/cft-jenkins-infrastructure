resource "azurerm_user_assigned_identity" "usermi" {
  resource_group_name = var.mi_rg
  location            = var.location
  name                = "jenkins-${var.key_vault_name}-mi"
  tags                = module.tags.common_tags
}

resource "azurerm_role_assignment" "miroles" {
  scope                = var.subscription_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "subidcontributer" {
  scope                = var.subscription_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "subiduseraccessadmin" {
  scope                = var.subscription_id
  role_definition_name = "User Access Administrator"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "hmctsacrpull" {
  scope                = var.subscription_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}
