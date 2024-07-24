data "azurerm_client_config" "this" {}

module "tags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = "3000-01-01"
}

locals {
  pact_broker_component = "pact-broker"
}

module "postgresql" {

  providers = {
    azurerm.postgres_network = azurerm.postgres_network
  }

  source = "git::https://github.com/hmcts/terraform-module-postgresql-flexible.git?ref=issue-issue-with-azurerm-version"
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

  pgsql_version = "14"
  # https://github.com/hmcts/terraform-module-postgresql-flexible/pull/28 changes collation to en_GB
  # setting to en_US means we can skip migrating the data as the collation here doesn't matter much
  collation = "en_US.utf8"

  # The ID of the principal to be granted admin access to the database server, should be the principal running this normally
  admin_user_object_id = data.azurerm_client_config.this.object_id

  enable_read_only_group_access = false

  common_tags = module.tags.common_tags
}

resource "azurerm_key_vault_secret" "db_username" {
  name         = "pact-db-user"
  value        = module.postgresql.username
  key_vault_id = azurerm_key_vault.jenkinskv.id
}

resource "azurerm_key_vault_secret" "db_password" {
  name         = "pact-db-password"
  value        = module.postgresql.password
  key_vault_id = azurerm_key_vault.jenkinskv.id
}
