env                                  = "sbox"
subscription_id                      = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
private_dns_subscription_id          = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
private_dns_resource_group_name      = "core-infra-intsvc-rg"
managed_identity_name                = "jenkins-sbox-mi"
managed_identity_resource_group_name = "managed-identities-sandbox-rg"
create_identity                      = true
cosmos_subscription_id               = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
alerts_subscription_id               = "8999dec3-0104-4a27-94ee-6588559729d1"

key_vaults = {
  "infra-vault-sandbox" = {
    name                = "infra-vault-sandbox"
    resource_group_name = "cnp-core-infra"
  }
}
