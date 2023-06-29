module "integration" {
    providers = {
    azurerm.private_endpoint = azurerm.private_endpoint
   }
  source                             = "../../modules/integration/"
  subscription_id                    = var.subscription_id
  env                                = var.env
  product                            = var.product
  location                           = var.location
  builtFrom                          = var.builtFrom
  expiresAfter                       = var.expiresAfter
  project                            = var.project
  servicebus_enable_private_endpoint = var.servicebus_enable_private_endpoint
  queue_name                         = var.queue_name
  key_vault_name                     = var.key_vault_name
  key_vault_rg_name                  = data.azurerm_resource_group.jenkins_key_vault_rg.name
  zone_redundant                     = var.zone_redundant
  enable_workflow                    = var.enable_workflow
}