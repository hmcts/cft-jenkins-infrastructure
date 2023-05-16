# Original code
# locals {
#   suffix = var.env == "ptlsbox" ? "-sbox" : ""
# }

module "tags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = lower(var.env)
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = "3000-01-01"
}

locals {
  suffix = var.env == "ptlsbox" ? "sandbox" : ""
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.product}-${var.env}-rg"
  location = var.location
  tags     = module.tags.common_tags
}

resource "azurerm_cosmosdb_account" "cosmosdb" {
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
  name                = var.database
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  # autoscale_settings {
  #   max_throughput = var.max_throughput
  # }
}

resource "azurerm_cosmosdb_sql_container" "cve-reports" {
  name                  = "cve-reports"
  resource_group_name   = azurerm_resource_group.rg.name
  account_name          = azurerm_cosmosdb_account.cosmosdb.name
  database_name         = azurerm_cosmosdb_sql_database.sqlapidb.name
  partition_key_path    = "/build/git_url"
  partition_key_version = 2
  throughput            = 400

  indexing_policy {
    indexing_mode = "Consistent"
  }
}

resource "azurerm_cosmosdb_sql_container" "container" {
  for_each              = var.partition_key
  name                  = each.key
  resource_group_name   = azurerm_resource_group.rg.name
  account_name          = azurerm_cosmosdb_account.cosmosdb.name
  database_name         = azurerm_cosmosdb_sql_database.sqlapidb.name
  partition_key_path    = each.value
  partition_key_version = 2
  throughput            = 1000

  indexing_policy {
    indexing_mode = "Consistent"
  }
}

resource "azurerm_cosmosdb_sql_role_assignment" "this" {
  resource_group_name = azurerm_cosmosdb_account.cosmosdb.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  # Cosmos DB Built-in Data Contributor
  role_definition_id = "${azurerm_cosmosdb_account.cosmosdb.id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id       = azurerm_user_assigned_identity.usermi.principal_id
  scope              = azurerm_cosmosdb_account.cosmosdb.id
}