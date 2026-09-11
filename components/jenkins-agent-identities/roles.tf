resource "azurerm_role_assignment" "contributor" {
  count = var.manage_contributor_role ? 1 : 0

  scope                = "/subscriptions/${var.subscription_id}"
  name                 = local.contributor_assignment_name
  role_definition_name = "Contributor"
  principal_id         = local.principal_id
}

resource "azurerm_role_assignment" "additional_contributor" {
  for_each = toset(var.additional_subscription_ids)

  scope = "/subscriptions/${each.value}"
  name = format(
    "%s-%s-%s-%s-%s",
    substr(md5("Contributor:/subscriptions/${each.value}:${local.principal_id}"), 0, 8),
    substr(md5("Contributor:/subscriptions/${each.value}:${local.principal_id}"), 8, 4),
    substr(md5("Contributor:/subscriptions/${each.value}:${local.principal_id}"), 12, 4),
    substr(md5("Contributor:/subscriptions/${each.value}:${local.principal_id}"), 16, 4),
    substr(md5("Contributor:/subscriptions/${each.value}:${local.principal_id}"), 20, 12)
  )
  role_definition_name = "Contributor"
  principal_id         = local.principal_id
}

resource "azurerm_role_assignment" "aks_cluster_admin" {
  count = var.manage_aks_cluster_admin_role ? 1 : 0

  scope                = "/subscriptions/${var.subscription_id}"
  name                 = local.aks_admin_assignment_name
  role_definition_name = "Azure Kubernetes Service Cluster Admin Role"
  principal_id         = local.principal_id
}

resource "azurerm_role_assignment" "private_dns_zone_contributor" {
  provider = azurerm.cft_mgmt

  scope                = "/subscriptions/${var.private_dns_subscription_id}/resourceGroups/${var.private_dns_resource_group_name}"
  name                 = local.private_dns_assignment_name
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = local.principal_id
}

resource "azurerm_role_assignment" "monitoring_reader" {
  provider             = azurerm.alerts-slack
  scope                = data.azurerm_monitor_action_group.slack_alerts.id
  name                 = local.principal_id
  role_definition_name = "Monitoring Reader"
  principal_id         = local.principal_id
}

resource "azurerm_role_assignment" "rbac_administrator" {
  count = var.manage_reader_role ? 1 : 0

  scope = "/subscriptions/${var.subscription_id}"
  name = uuidv5(
    "url",
    "Role Based Access Control Administrator:/subscriptions/${var.subscription_id}:${local.principal_id}"
  )
  role_definition_name = "Role Based Access Control Administrator"
  principal_id         = local.principal_id
  condition_version    = "2.0"
  condition            = <<-EOT
    (
      !(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})
      OR
      @Request[Microsoft.Authorization/roleAssignments:RoleDefinitionId]
        ForAnyOfAnyValues:GuidEquals {acdd72a7-3385-48ef-bd42-f606fba81ae7, a97b65f3-24c7-4388-baec-2e87135dc908, 5e0bd9bd-7b93-4f28-af87-19fc36ad61bd}
    )
    AND
    (
      !(ActionMatches{'Microsoft.Authorization/roleAssignments/delete'})
      OR
      @Resource[Microsoft.Authorization/roleAssignments:RoleDefinitionId]
        ForAnyOfAnyValues:GuidEquals {acdd72a7-3385-48ef-bd42-f606fba81ae7, a97b65f3-24c7-4388-baec-2e87135dc908, 5e0bd9bd-7b93-4f28-af87-19fc36ad61bd}
    )
  EOT
}
