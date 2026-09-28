env                                  = "sbox"
subscription_id                      = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
private_dns_subscription_id          = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
private_dns_resource_group_name      = "core-infra-intsvc-rg"
managed_identity_name                = "jenkins-sbox-mi"
managed_identity_resource_group_name = "managed-identities-sandbox-rg"
create_identity                      = true
cosmos_subscription_id               = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
rbac_admin_roles                     = ["Storage Account Contributor", "Storage Blob Data Reader", "Storage Blob Data Contributor", "Cognitive Services OpenAI User", "Cognitive Services User", "Reader"]
additional_reader_subscription_ids   = ["ed302caf-ec27-4c64-a05e-85731c3ce90e"]

key_vaults = {
  "infra-vault-sandbox" = {
    name                = "infra-vault-sandbox"
    resource_group_name = "cnp-core-infra"
  }
}
