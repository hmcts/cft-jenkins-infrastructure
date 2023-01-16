data "azurerm_client_config" "this" {}

module "tags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = "2023-01-01"
}

locals {
  pact_broker_component = "pact-broker"
}

data "azurerm_subnet" "postgres" {
  name                 = "postgresql"
  resource_group_name  = "cft-${var.env}-network-rg"
  virtual_network_name = "cft-${var.env}-vnet"
}

module "postgresql" {
  source = "git::https://github.com/hmcts/terraform-module-postgresql-flexible.git?ref=master"
  env    = var.env

  product       = var.product
  name          = "cft-${local.pact_broker_component}"
  component     = local.pact_broker_component
  business_area = "cft"

  pgsql_databases = [
    {
      name : "pact"
    }
  ]

  pgsql_delegated_subnet_id = data.azurerm_subnet.postgres.id

  # Set your PostgreSQL version, note AzureAD auth requires version 12 (and not 11 or 13 currently)
  pgsql_version = "14"

  # The ID of the principal to be granted admin access to the database server, should be the principal running this normally
  admin_user_object_id = data.azurerm_client_config.this.object_id

  enable_read_only_group_access = false

  common_tags = module.tags.common_tags
}

data "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  resource_group_name = "core-infra-intsvc-rg"
}

resource "azurerm_key_vault_secret" "db_username" {
  name         = "pact-db-user"
  value        = module.postgresql.username
  key_vault_id = data.azurerm_key_vault.this.id
}

resource "azurerm_key_vault_secret" "db_password" {
  name         = "pact-db-password"
  value        = module.postgresql.password
  key_vault_id = data.azurerm_key_vault.this.id
}
