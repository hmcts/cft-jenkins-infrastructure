# DTS Operations - GA, used by the GA-Prod-Tenant WIF service connection.
# Adopt the existing read-only policy in ptl before adding secret Set access.
import {
  for_each = var.env == "ptl" ? toset(["ptl"]) : toset([])
  to       = azurerm_key_vault_access_policy.app_proxy_wif_secret_management
  id       = "${azurerm_key_vault.jenkinskv.id}/objectId/0ec60e03-4262-44ce-abcf-83e2131c9207"
}

resource "azurerm_key_vault_access_policy" "app_proxy_wif_secret_management" {
  key_vault_id = azurerm_key_vault.jenkinskv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "0ec60e03-4262-44ce-abcf-83e2131c9207"

  secret_permissions = ["Get", "List", "Set"]
}
