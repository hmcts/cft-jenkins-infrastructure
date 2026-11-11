resource "azurerm_key_vault_access_policy" "app_proxy_management_wif" {
  count = var.env == "prod" ? 1 : 0

  key_vault_id = data.azurerm_key_vault.infra_vault["infra-vault-prod"].id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "ab4e3b65-cc4c-4819-8a4c-47618bce543d"

  secret_permissions = ["Get"]
}
