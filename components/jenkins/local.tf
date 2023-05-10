locals {
  product = replace(var.product, "cft-", "")
  pact_broker_component = "pact-broker"
  disk_rg_name = var.env == "ptlsbox" ? upper(data.azurerm_resource_group.disks_resource_group.name) : data.azurerm_resource_group.disks_resource_group.name
}
