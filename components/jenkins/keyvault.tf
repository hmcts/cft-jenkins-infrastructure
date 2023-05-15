resource "azurerm_key_vault" "jenkinskv" {
  location                        = var.location
  name                            = var.key_vault_name
  resource_group_name             = data.azurerm_resource_group.jenkins_key_vault_rg.name
  sku_name                        = "standard"
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = 90
  enabled_for_deployment          = true
  purge_protection_enabled        = true
  enabled_for_template_deployment = true
  enable_rbac_authorization       = false
  tags                            = var.env == "ptlsbox" ? module.tags.common_tags : merge(module.tags.common_tags, local.ptl_kv_tags)
}

locals {
  ptl_kv_tags = {
    dataClassification = "internal"
    activityName       = "AKS"
    costCentre         = "10245117"
    managedBy          = "Platform Engineering"
  }
}