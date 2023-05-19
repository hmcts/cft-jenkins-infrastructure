locals {
  suffix = var.env == "ptlsbox" ? "sandbox" : "prod"
  prefix = var.env == "ptlsbox" ? "sandbox-" : ""
}


resource "azurerm_resource_group" "rg" {
  provider = azurerm.cosmosdb

  name     = "pipelinemetrics-database-${local.suffix}"
  location = var.location
  tags     = module.tags.common_tags
}

resource "azurerm_user_assigned_identity" "usermi" {
  resource_group_name = var.mi_rg
  location            = var.location
  name                = "jenkins-${var.key_vault_name}-mi"
  tags                = module.tags.common_tags
}

resource "azurerm_cosmosdb_account" "cosmosdb" {
  provider = azurerm.cosmosdb

  name                      = "${local.prefix}pipeline-metrics"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg.name
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  tags                      = module.tags.common_tags
  enable_automatic_failover = false
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
  partition_key_path    = "/build/git_url"
  partition_key_version = 2
  throughput            = 400

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
  partition_key_path    = "/_partitionKey"
  partition_key_version = 2
  throughput            = var.env == "ptl" && each.value == "pipeline-metrics" ? 1500 : 1000

  indexing_policy {
    indexing_mode = "consistent"
    included_path {
      path = "/*"
    }
  }
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
