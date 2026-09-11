env                                  = "prod"
subscription_id                      = "8999dec3-0104-4a27-94ee-6588559729d1"
additional_subscription_ids          = ["8cbc6f36-7c56-4963-9d36-739db5d00b27", "5ca62022-6aa2-4cee-aaa7-e7536c8d566c"]
private_dns_subscription_id          = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_resource_group_name      = "core-infra-intsvc-rg"
managed_identity_name                = "jenkins-prod-mi"
managed_identity_resource_group_name = "managed-identities-prod-rg"
create_identity                      = true
cosmos_subscription_id               = "8999dec3-0104-4a27-94ee-6588559729d1"

key_vaults = {
  "infra-vault-prod" = {
    name                = "infra-vault-prod"
    resource_group_name = "core-infra-prod"
  }
}
