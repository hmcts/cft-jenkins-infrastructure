resource "azurerm_role_assignment" "managed_identity_operator" {
  for_each = { for k, v in var.operations_groups : k => v }
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourcegroups/${var.mi_rg}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/jenkins-${var.key_vault_name}-mi"
  role_definition_name = "Managed Identity Operator"
  principal_id         = data.azuread_group.dts_operations[each.key].object_id
}