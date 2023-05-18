locals {
  suffix = var.env == "ptlsbox" ? "sandbox" : var.env
}

resource "azurerm_resource_group" "rg" {
  provider = azurerm.cosmosdb

  name     = "pipelinemetrics-database-${local.suffix}"
  location = var.location
  tags     = module.tags.common_tags
}

resource "azurerm_user_assigned_identity" "usermi" {
  resource_group_name = data.azurerm_resource_group.mi.name
  location            = var.location
  name                = "jenkins-cftsbox-intsvc-mi"
  tags                = module.tags.common_tags
}

resource "azurerm_cosmosdb_account" "cosmosdb" {
  provider = azurerm.cosmosdb

  name                      = "${local.suffix}-pipeline-metrics"
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

  name                = var.database
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
  }
}

resource "azurerm_cosmosdb_sql_container" "container" {
  provider = azurerm.cosmosdb

  for_each              = var.partition_key
  name                  = each.key
  resource_group_name   = azurerm_resource_group.rg.name
  account_name          = azurerm_cosmosdb_account.cosmosdb.name
  database_name         = azurerm_cosmosdb_sql_database.sqlapidb.name
  partition_key_path    = each.value
  partition_key_version = 2
  throughput            = 1000

  indexing_policy {
    indexing_mode = "consistent"
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
