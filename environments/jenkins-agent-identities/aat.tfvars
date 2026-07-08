env                                  = "aat"
subscription_id                      = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
additional_subscription_ids          = ["96c274ce-846d-4e48-89a7-d528432298a7", "867a878b-cb68-4de5-9741-361ac9e178b6"]
private_dns_subscription_id          = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_resource_group_name      = "core-infra-intsvc-rg"
managed_identity_name                = "jenkins-aat-mi"
managed_identity_resource_group_name = "managed-identities-aat-rg"
create_identity                      = true
cosmos_subscription_id               = "8999dec3-0104-4a27-94ee-6588559729d1"

key_vaults = {
  "infra-vault-nonprod" = {
    name                = "infra-vault-nonprod"
    resource_group_name = "cnp-core-infra"
  }
}

import_to = azurerm_role_assignment.additional_contributor["96c274ce-846d-4e48-89a7-d528432298a7"]
import_id = "/subscriptions/96c274ce-846d-4e48-89a7-d528432298a7/providers/Microsoft.Authorization/roleAssignments/01efa51a-cf11-5ba1-f6b5-7241b4203052"