env                                  = "ithc"
subscription_id                      = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
private_dns_subscription_id          = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_resource_group_name      = "core-infra-intsvc-rg"
managed_identity_name                = "jenkins-ithc-mi"
managed_identity_resource_group_name = "managed-identities-ithc-rg"
create_identity                      = true
cosmos_subscription_id               = "8999dec3-0104-4a27-94ee-6588559729d1"
alerts_subscription_id               = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"

key_vaults = {
  "infra-vault-qa" = {
    name                = "infra-vault-qa"
    resource_group_name = "cnp-core-infra"
  }
}
