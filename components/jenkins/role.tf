resource "azurerm_user_assigned_identity" "usermi" {
  resource_group_name = var.mi_rg
  location            = var.location
  name                = "dcd_sp_aks_dcd-cftapps-sbox_v2"
  tags                = module.tags.common_tags
}

resource "azurerm_role_assignment" "miroles" {
  scope                = data.azurerm_resource_group.acr_rg.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "subidcontributer" {
  scope                = data.azurerm_resource_group.acr_rg.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "subiduseraccessadmin" {
  scope                = data.azurerm_resource_group.acr_rg.id
  role_definition_name = "User Access Administrator"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "hmctsacrpull" {
  scope                = data.azurerm_resource_group.acr_rg.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}
