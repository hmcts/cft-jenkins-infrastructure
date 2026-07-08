env                                  = "demo"
subscription_id                      = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
additional_subscription_ids          = ["d025fece-ce99-4df2-b7a9-b649d3ff2060", "c68a4bed-4c3d-4956-af51-4ae164c1957c"]
private_dns_subscription_id          = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_resource_group_name      = "core-infra-intsvc-rg"
managed_identity_name                = "jenkins-demo-mi"
managed_identity_resource_group_name = "managed-identities-demo-rg"
create_identity                      = true
cosmos_subscription_id               = "8999dec3-0104-4a27-94ee-6588559729d1"

key_vaults = {
  "infra-vault-nonprod" = {
    name                = "infra-vault-nonprod"
    resource_group_name = "cnp-core-infra"
  }
}

import_to = azurerm_role_assignment.additional_contributor["d025fece-ce99-4df2-b7a9-b649d3ff2060"]
import_id = "/subscriptions/d025fece-ce99-4df2-b7a9-b649d3ff2060/providers/Microsoft.Authorization/roleAssignments/a2e59b2b-2ba5-02fe-6c77-eaf410d99fe9"