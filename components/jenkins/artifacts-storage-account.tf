resource "azurerm_storage_account" "storage_account" {
  count = var.env == "ptl" ? 1 : 0

  name                            = "cftjenkinsafactptl"
  resource_group_name             = data.azurerm_resource_group.jenkins_key_vault_rg.name
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

resource "azurerm_storage_container" "job_cache" {
  count = var.env == "ptl" ? 1 : 0

  name                  = "job-cache"
  storage_account_id    = azurerm_storage_account.storage_account[0].id
  container_access_type = "private"
}

data "azurerm_storage_account" "sandbox_job_cache" {
  count = var.env == "ptlsbox" ? 1 : 0

  provider            = azurerm.cache_storage
  name                = "mgmtbuildlogstoresandbox"
  resource_group_name = "mgmt-buildlog-store-sandbox"
}

resource "azurerm_storage_management_policy" "job_cache" {
  count = contains(["ptl", "ptlsbox"], var.env) ? 1 : 0

  provider           = azurerm.cache_storage
  storage_account_id = var.env == "ptl" ? azurerm_storage_account.storage_account[0].id : data.azurerm_storage_account.sandbox_job_cache[0].id

  rule {
    name    = "delete-job-cache-after-30-days"
    enabled = true

    filters {
      prefix_match = ["job-cache/"]
      blob_types   = ["blockBlob"]
    }

    actions {
      base_blob {
        delete_after_days_since_modification_greater_than = 30
      }
    }
  }
}

resource "azurerm_key_vault_secret" "job_cache_account_key" {
  count = var.env == "ptl" ? 1 : 0

  name         = "jenkins-job-cache-key"
  value        = azurerm_storage_account.storage_account[0].primary_access_key
  key_vault_id = azurerm_key_vault.jenkinskv.id
}
