# Jenkins Agent Managed Identities

This component manages one Jenkins VM-agent managed identity per run, plus required RBAC.

## Roles assigned
- `Contributor` on the target environment subscription
- `Azure Kubernetes Service Cluster Admin Role` on the target environment subscription
- `Private DNS Zone Contributor` on the shared private DNS resource group in `reform-cft-mgmt`

## Environment tfvars
`environments/jenkins-agent-identities/` contains one tfvars file per CFT environment:
- `sbox`, `preview`, `aat`, `ithc`, `perftest`, `demo`, `prod`
- `ptlsbox`, `ptl` (existing identities: `create_identity = false`)

## Enable role assignment using Azure Role Based Access Control Administrator

In Azure, an RBAC Administrator is a role that governs what roles an identity can assign.

For example, you can grant an identity RBAC Administrator with Storage Account Contributor.

That means the identity can only grant that role specifically over any resources it is an RBAC Administrator of.

In the case of Jenkins, the identity used by the agents can grant Storage Account Contributor access to any resource it creates but it cannot grant Owner.

To define the roles Jenkins can assign, add its name to `rbac_admin_roles` in the tfvars file.

```
rbac_admin_roles = ["Storage Account Contributor", "Storage Blob Data Contributor"]
```

Note: the role definition name must be exact for this to work. If you don't enter a valid role, the pipeline will run until timing out as the role cannot be found rather than failing because the role doesn't exist.

## Warning

Because of the nature of the Azure API at the time of writing (September 2026), adding more roles to this list will delete the RBAC Administrator role from the identity before re-adding it with the new assignable roles.

## Private DNS Zone IDs

Most subscriptions should use the same private DNS zone subscription but sandbox needs to access two.

This is because private endpoint dns zones only live in PTL so sandbox needs access to its own zones and PTL.