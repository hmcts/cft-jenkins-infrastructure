locals {
  suffix = var.env == "ptlsbox" ? "sandbox" : "prod"
  prefix = var.env == "ptlsbox" ? "sandbox-" : ""
}


resource "azurerm_resource_group" "rg" {
  provider = azurerm.cosmosdb

  name     = "pipelinemetrics-database-${local.suffix}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_user_assigned_identity" "usermi" {
  resource_group_name = var.mi_rg
  location            = var.location
  name                = "jenkins-${var.key_vault_name}-mi"
  tags                = local.common_tags
}

resource "azurerm_cosmosdb_account" "cosmosdb" {
  provider = azurerm.cosmosdb

  name                       = "${local.prefix}pipeline-metrics"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  offer_type                 = "Standard"
  kind                       = "GlobalDocumentDB"
  tags                       = local.common_tags
  automatic_failover_enabled = true
  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  geo_location {
    location          = "UK West"
    failover_priority = 1
  }
}

resource "azurerm_cosmosdb_sql_database" "sqlapidb" {
  provider = azurerm.cosmosdb

  name                = var.cosmos_database_name
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
}

resource "azurerm_cosmosdb_sql_container" "cve-reports" {
  provider = azurerm.cosmosdb

  name                  = "cve-reports"
  resource_group_name   = azurerm_resource_group.rg.name
  account_name          = azurerm_cosmosdb_account.cosmosdb.name
  database_name         = azurerm_cosmosdb_sql_database.sqlapidb.name
  partition_key_paths   = ["/build/git_url"]
  partition_key_version = 2

  autoscale_settings {
    max_throughput = var.max_throughput
  }

  indexing_policy {
    indexing_mode = "consistent"
    included_path {
      path = "/*"
    }
  }
}

resource "azurerm_cosmosdb_sql_container" "container" {
  provider = azurerm.cosmosdb

  for_each              = toset(var.container_names)
  name                  = each.value
  resource_group_name   = azurerm_resource_group.rg.name
  account_name          = azurerm_cosmosdb_account.cosmosdb.name
  database_name         = azurerm_cosmosdb_sql_database.sqlapidb.name
  partition_key_paths   = ["/_partitionKey"]
  partition_key_version = 2

  autoscale_settings {
    max_throughput = var.max_throughput
  }

  indexing_policy {
    indexing_mode = "consistent"
    included_path {
      path = "/*"
    }
  }
}

resource "azurerm_cosmosdb_sql_role_assignment" "monitoring_mi_assignment" {
  provider = azurerm.cosmosdb

  resource_group_name = azurerm_cosmosdb_account.cosmosdb.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  # Cosmos DB Built-in Data Contributor
  role_definition_id = "${azurerm_cosmosdb_account.cosmosdb.id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id       = data.azurerm_user_assigned_identity.monitoring_mi.principal_id
  scope              = azurerm_cosmosdb_account.cosmosdb.id
}



resource "azurerm_cosmosdb_sql_role_assignment" "this" {
  provider = azurerm.cosmosdb

  resource_group_name = azurerm_cosmosdb_account.cosmosdb.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  # Cosmos DB Built-in Data Contributor
  role_definition_id = "${azurerm_cosmosdb_account.cosmosdb.id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id       = azurerm_user_assigned_identity.usermi.principal_id
  scope              = azurerm_cosmosdb_account.cosmosdb.id
}

data "azuread_service_principals" "pipeline" {
  display_names = [
    "DTS Bootstrap (sub:dcd-cftapps-sbox)",
    "DTS Bootstrap (sub:dcd-cftapps-dev)",
    "DTS Bootstrap (sub:dcd-cftapps-ithc)",
    "DTS Bootstrap (sub:dcd-cftapps-demo)",
    "DTS Bootstrap (sub:dcd-cftapps-stg)",
    "DTS Bootstrap (sub:dcd-cftapps-test)",
    "DTS Bootstrap (sub:dcd-cftapps-prod)",
    "DTS Bootstrap (sub:dts-cftsbox-intsvc)",
    "DTS Bootstrap (sub:dts-cftptl-intsvc)"
  ]
}

resource "azurerm_role_assignment" "rbac_admin" {
  provider             = azurerm.cosmosdb
  for_each             = { for sp in data.azuread_service_principals.pipeline.service_principals : sp.object_id => sp }
  role_definition_name = "DocumentDB Account Contributor"
  principal_id         = each.value.object_id
  scope                = azurerm_cosmosdb_account.cosmosdb.id
}
