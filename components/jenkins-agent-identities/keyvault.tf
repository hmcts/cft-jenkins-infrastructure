resource "azurerm_key_vault_access_policy" "infra_vault" {
  for_each = { for k, v in var.key_vaults : k => v if var.key_vaults != {} }

  key_vault_id = data.azurerm_key_vault.infra_vault[each.key].id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = local.principal_id

  key_permissions = [
    "Create",
    "Delete",
    "Encrypt",
    "Decrypt",
    "Get",
    "Import",
    "List",
    "Recover",
    "Restore",
    "Update",
    "Backup",
    "UnwrapKey",
    "WrapKey",
    "Verify",
    "Sign",
    "Purge"
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Recover",
    "Restore",
    "Set",
    "Purge"
  ]

  certificate_permissions = [
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import"
  ]
}

resource "azurerm_key_vault_access_policy" "cftptl_vault" {
  count = var.env == "prod" ? 1 : 0

  key_vault_id = data.azurerm_key_vault.cftptl_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = local.principal_id

  key_permissions = [
    "Create",
    "Delete",
    "Encrypt",
    "Decrypt",
    "Get",
    "Import",
    "List",
    "Recover",
    "Restore",
    "Update",
    "Backup",
    "UnwrapKey",
    "WrapKey",
    "Verify",
    "Sign",
    "Purge"
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Recover",
    "Restore",
    "Set",
    "Purge"
  ]

  certificate_permissions = [
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import"
  ]
}
