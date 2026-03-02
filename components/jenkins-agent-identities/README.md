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
