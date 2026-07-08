env                                  = "perftest"
subscription_id                      = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
additional_subscription_ids          = ["8a07fdcd-6abd-48b3-ad88-ff737a4b9e3c", "3eec5bde-7feb-4566-bfb6-805df6e10b90"]
private_dns_subscription_id          = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_resource_group_name      = "core-infra-intsvc-rg"
managed_identity_name                = "jenkins-perftest-mi"
managed_identity_resource_group_name = "managed-identities-perftest-rg"
create_identity                      = true
cosmos_subscription_id               = "8999dec3-0104-4a27-94ee-6588559729d1"

key_vaults = {
  "infra-vault-qa" = {
    name                = "infra-vault-qa"
    resource_group_name = "cnp-core-infra"
  }
}

import_to = azurerm_role_assignment.additional_contributor["8a07fdcd-6abd-48b3-ad88-ff737a4b9e3c"]
import_id = "/subscriptions/8a07fdcd-6abd-48b3-ad88-ff737a4b9e3c/providers/Microsoft.Authorization/roleAssignments/b783c469-bb22-858f-1a13-de4c507f1217"