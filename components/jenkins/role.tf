locals {
  ptl = {

    stg  = "74dacd4f-a248-45bb-a2f0-af700dc4cf68",
    test = "3eec5bde-7feb-4566-bfb6-805df6e10b90",
    demo = "c68a4bed-4c3d-4956-af51-4ae164c1957c",
    ithc = "ba71a911-e0d6-4776-a1a6-079af1df7139",
    prod = "5ca62022-6aa2-4cee-aaa7-e7536c8d566c",
    dev  = "867a878b-cb68-4de5-9741-361ac9e178b6"
  }
  ptlsbox = {
    sbox = "a8140a9e-f1b0-481f-a4de-09e2ee23f7ab"
  }
}

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

  for_each             = data.azurerm_client_config.current.subscription_id == "6c4d2513-a873-41b4-afdd-b05a33206631" ? local.ptl : local.ptlsbox
  scope                = "/subscriptions/${each.value}"
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "subiduseraccessadmin" {

  for_each             = data.azurerm_client_config.current.subscription_id == "6c4d2513-a873-41b4-afdd-b05a33206631" ? local.ptl : local.ptlsbox
  scope                = "/subscriptions/${each.value}"
  role_definition_name = "User Access Administrator"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "hmctsacrpull" {
  scope                = data.azurerm_resource_group.acr_rg.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}
