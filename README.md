# Jenkins Infrastructure for CFT platform

## Purpose

This respository is responsible for the creation of CFT Jenkins infrastructure using Terraform, and automates the Terraform workflow for maintaining existing resources and adding new resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.37.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.37.0 |
| <a name="provider_azurerm.cft_mgmt"></a> [azurerm.cft\_mgmt](#provider\_azurerm.cft\_mgmt) | 4.37.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.aks_cluster_admin](https://registry.terraform.io/providers/hashicorp/azurerm/4.37.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.contributor](https://registry.terraform.io/providers/hashicorp/azurerm/4.37.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.private_dns_zone_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/4.37.0/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.37.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.existing](https://registry.terraform.io/providers/hashicorp/azurerm/4.37.0/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_builtFrom"></a> [builtFrom](#input\_builtFrom) | Compatibility variable for shared pipeline template. | `string` | `""` | no |
| <a name="input_create_identity"></a> [create\_identity](#input\_create\_identity) | Whether to create the managed identity (true) or reference an existing one (false). | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Name of the target CFT environment for this managed identity. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location for the managed identity. | `string` | `"UK South"` | no |
| <a name="input_managed_identity_name"></a> [managed\_identity\_name](#input\_managed\_identity\_name) | Managed identity name. | `string` | n/a | yes |
| <a name="input_managed_identity_resource_group_name"></a> [managed\_identity\_resource\_group\_name](#input\_managed\_identity\_resource\_group\_name) | Resource group where the managed identity exists or will be created. | `string` | n/a | yes |
| <a name="input_private_dns_resource_group_name"></a> [private\_dns\_resource\_group\_name](#input\_private\_dns\_resource\_group\_name) | Resource group in reform-cft-mgmt containing private DNS zones. | `string` | `"core-infra-intsvc-rg"` | no |
| <a name="input_private_dns_subscription_id"></a> [private\_dns\_subscription\_id](#input\_private\_dns\_subscription\_id) | Subscription ID that hosts the shared private DNS zones (reform-cft-mgmt). | `string` | `"04d27a32-7a07-48b3-95b8-3c8691e1a263"` | no |
| <a name="input_product"></a> [product](#input\_product) | Compatibility variable for shared pipeline template. | `string` | `""` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Target environment subscription ID for managed identity and subscription-level role assignments. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags to apply when creating the managed identity. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
