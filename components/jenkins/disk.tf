locals {
  product      = replace(var.product, "cft-", "")
  disk_rg_name = var.env == "ptlsbox" ? upper(data.azurerm_resource_group.disks_resource_group.name) : data.azurerm_resource_group.disks_resource_group.name
}

resource "azurerm_managed_disk" "disk" {
  name                       = "${local.product}-disk"
  location                   = var.location
  resource_group_name        = local.disk_rg_name
  storage_account_type       = "PremiumV2_LRS"
  create_option              = "Copy"
  hyper_v_generation         = "V1"
  disk_iops_read_write       = "5000"
  disk_size_gb               = "1024"
  on_demand_bursting_enabled = false
  trusted_launch_enabled     = false
  tier                       = "P30"
  # Hardcoded string literal taken from Azure, used to avoid terraform replacement of exising resource
  source_resource_id = var.jenkins_disk_source_resource_id
  tags               = local.common_tags
}
