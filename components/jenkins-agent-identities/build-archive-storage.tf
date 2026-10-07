data "azurerm_storage_account" "build_archive_nonprod" {
  count    = var.build_archive_nonprod_storage_account == null ? 0 : 1
  provider = azurerm.cft-ptl

  name                = var.build_archive_nonprod_storage_account.name
  resource_group_name = var.build_archive_nonprod_storage_account.resource_group_name
}

resource "azurerm_role_assignment" "build_archive_nonprod" {
  count = var.build_archive_nonprod_storage_account == null ? 0 : 1

  scope                = data.azurerm_storage_account.build_archive_nonprod[0].id
  role_definition_name = var.build_archive_role_definition_name
  principal_id         = local.principal_id
}

data "azurerm_storage_account" "build_archive_prod" {
  count    = var.build_archive_prod_storage_account == null ? 0 : 1
  provider = azurerm.cosmosdb

  name                = var.build_archive_prod_storage_account.name
  resource_group_name = var.build_archive_prod_storage_account.resource_group_name
}

resource "azurerm_role_assignment" "build_archive_prod" {
  count = var.build_archive_prod_storage_account == null ? 0 : 1

  scope                = data.azurerm_storage_account.build_archive_prod[0].id
  role_definition_name = var.build_archive_role_definition_name
  principal_id         = local.principal_id
}
