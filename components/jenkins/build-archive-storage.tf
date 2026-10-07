locals {
  # Every secret in the Jenkins key vault becomes a credential that any build can use. Uploads
  # authenticate with the agent's managed identity and only read the username, so the account
  # keys are deliberately not stored.
  build_archive_credential_password = "unused-uploads-authenticate-with-managed-identity"
}

resource "azurerm_resource_group" "build_archive_nonprod" {
  count = var.env == "ptl" ? 1 : 0

  name     = "mgmt-buildlog-store-nonprod"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "build_archive_nonprod" {
  count = var.env == "ptl" ? 1 : 0

  name                            = "mgmtbuildlogstorenonprod"
  resource_group_name             = azurerm_resource_group.build_archive_nonprod[0].name
  location                        = var.location
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "ZRS"
  allow_nested_items_to_be_public = false

  blob_properties {
    delete_retention_policy {
      days = 14
    }
  }

  tags = local.common_tags
}

resource "azurerm_storage_container" "build_archive_nonprod" {
  for_each = var.env == "ptl" ? toset(["jenkins-build-archive", "performance"]) : toset([])

  name                  = each.key
  storage_account_id    = azurerm_storage_account.build_archive_nonprod[0].id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "build_archive_nonprod" {
  count = var.env == "ptl" ? 1 : 0

  scope                = azurerm_storage_account.build_archive_nonprod[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_key_vault_secret" "build_archive_nonprod" {
  count = var.env == "ptl" ? 1 : 0

  name         = "buildlog-storage-account-nonprod"
  value        = local.build_archive_credential_password
  key_vault_id = azurerm_key_vault.jenkinskv.id

  tags = {
    type     = "username"
    username = azurerm_storage_account.build_archive_nonprod[0].name
  }
}

# Prod build logs live in the prod subscription: every storage account in DTS-CFTPTL-INTSVC is
# readable by all CFT developers through a subscription-wide Blob Data Reader assignment.
data "azurerm_resource_group" "build_archive_prod" {
  count    = var.env == "ptl" ? 1 : 0
  provider = azurerm.build_archive_prod

  name = "mgmt-buildlog-store-prod"
}

resource "azurerm_storage_account" "build_archive_prod" {
  count    = var.env == "ptl" ? 1 : 0
  provider = azurerm.build_archive_prod

  name                            = "mgmtbuildlogstoreprod"
  resource_group_name             = data.azurerm_resource_group.build_archive_prod[0].name
  location                        = var.location
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "ZRS"
  allow_nested_items_to_be_public = false

  blob_properties {
    delete_retention_policy {
      days = 14
    }
  }

  tags = local.common_tags
}

resource "azurerm_storage_container" "build_archive_prod" {
  count    = var.env == "ptl" ? 1 : 0
  provider = azurerm.build_archive_prod

  name                  = "jenkins-build-archive"
  storage_account_id    = azurerm_storage_account.build_archive_prod[0].id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "build_archive_prod" {
  count    = var.env == "ptl" ? 1 : 0
  provider = azurerm.build_archive_prod

  scope                = azurerm_storage_account.build_archive_prod[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_key_vault_secret" "build_archive_prod" {
  count = var.env == "ptl" ? 1 : 0

  name         = "buildlog-storage-account-prod"
  value        = local.build_archive_credential_password
  key_vault_id = azurerm_key_vault.jenkinskv.id

  tags = {
    type     = "username"
    username = azurerm_storage_account.build_archive_prod[0].name
  }
}
