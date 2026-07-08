env                                  = "ithc"
subscription_id                      = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
additional_subscription_ids          = ["62864d44-5da9-4ae9-89e7-0cf33942fa09", "ba71a911-e0d6-4776-a1a6-079af1df7139"]
private_dns_subscription_id          = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_resource_group_name      = "core-infra-intsvc-rg"
managed_identity_name                = "jenkins-ithc-mi"
managed_identity_resource_group_name = "managed-identities-ithc-rg"
create_identity                      = true
cosmos_subscription_id               = "8999dec3-0104-4a27-94ee-6588559729d1"

key_vaults = {
  "infra-vault-qa" = {
    name                = "infra-vault-qa"
    resource_group_name = "cnp-core-infra"
  }
}

import_to = azurerm_role_assignment.additional_contributor["62864d44-5da9-4ae9-89e7-0cf33942fa09"]
import_id = "/subscriptions/62864d44-5da9-4ae9-89e7-0cf33942fa09/providers/Microsoft.Authorization/roleAssignments/32efeecb-c832-b5e8-c71f-fe765d4d9024"