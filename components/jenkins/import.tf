import {
  for_each = local.group_members
  to       = azuread_group_member.jenkins
  id       = each.value
}