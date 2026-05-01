resource "azuread_group_member" "jenkins" {
  group_object_id  = data.azuread_group.directory_readers.object_id
  member_object_id = azurerm_user_assigned_identity.usermi.principal_id
}