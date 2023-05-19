# Jenkins Infrastructure for CFT platform

## Purpose
This respository is responsible for the creation of CFT Jenkins infrastructure using Terraform, and automates the Terraform workflow for maintaining existing resources and adding new resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.4.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.57.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | git::https://github.com/hmcts/terraform-module-postgresql-flexible.git | master |
| <a name="module_tags"></a> [tags](#module\_tags) | git::https://github.com/hmcts/terraform-module-common-tags.git | master |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.jenkinskv](https://registry.terraform.io/providers/hashicorp/azurerm/3.57.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.db_password](https://registry.terraform.io/providers/hashicorp/azurerm/3.57.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.db_username](https://registry.terraform.io/providers/hashicorp/azurerm/3.57.0/docs/resources/key_vault_secret) | resource |
| [azurerm_managed_disk.disk](https://registry.terraform.io/providers/hashicorp/azurerm/3.57.0/docs/resources/managed_disk) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.57.0/docs/data-sources/client_config) | data source |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.57.0/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.disks_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.57.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.jenkins_key_vault_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.57.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/3.57.0/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_builtFrom"></a> [builtFrom](#input\_builtFrom) | Name of the GitHub repository this application is being built from. | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Name of the environment to deploy the resource. | `string` | n/a | yes |
| <a name="input_jenkins_disk_source_resource_id"></a> [jenkins\_disk\_source\_resource\_id](#input\_jenkins\_disk\_source\_resource\_id) | The ID of existing Managed Disk or Snapshot to copy | `string` | n/a | yes |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Key vault to store secrets in | `string` | n/a | yes |
| <a name="input_key_vault_rg"></a> [key\_vault\_rg](#input\_key\_vault\_rg) | Resource group that holds the Jenkins Key Vault | `string` | `"core-infra-intsvc-rg"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location to deploy the resource | `string` | `"UK South"` | no |
| <a name="input_product"></a> [product](#input\_product) | Name of the product. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription to run against | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->