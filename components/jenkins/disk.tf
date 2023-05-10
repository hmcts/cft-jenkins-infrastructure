resource "azurerm_managed_disk" "disk" {
  name                       = "${local.product}-disk"
  location                   = var.location
  resource_group_name        = local.disk_rg_name
  storage_account_type       = "Premium_LRS"
  create_option              = "Copy"
  hyper_v_generation         = "V1"
  disk_iops_read_write       = "5000"
  disk_size_gb               = "1024"
  on_demand_bursting_enabled = false
  trusted_launch_enabled     = false
  tier                       = "P30"
  source_resource_id         = var.source_resource_id
  tags                       = module.tags.common_tags
}