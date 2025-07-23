# Jenkins Infrastructure for CFT platform

## Purpose

This respository is responsible for the creation of CFT Jenkins infrastructure using Terraform, and automates the Terraform workflow for maintaining existing resources and adding new resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.117.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |
| <a name="provider_azurerm.cosmosdb"></a> [azurerm.cosmosdb](#provider\_azurerm.cosmosdb) | 3.117.1 |
| <a name="provider_azurerm.managed_identity_infra_subs"></a> [azurerm.managed\_identity\_infra\_subs](#provider\_azurerm.managed\_identity\_infra\_subs) | 3.117.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_jenkins-webhook-relay"></a> [jenkins-webhook-relay](#module\_jenkins-webhook-relay) | git::https://github.com/hmcts/terraform-module-jenkins-webhook-infrastructure | main |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | git::https://github.com/hmcts/terraform-module-postgresql-flexible.git | master |
| <a name="module_tags"></a> [tags](#module\_tags) | git::https://github.com/hmcts/terraform-module-common-tags.git | master |

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_account.cosmosdb](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_sql_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_sql_container.cve-reports](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_sql_database.sqlapidb](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/cosmosdb_sql_database) | resource |
| [azurerm_cosmosdb_sql_role_assignment.monitoring_mi_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/cosmosdb_sql_role_assignment) | resource |
| [azurerm_cosmosdb_sql_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/cosmosdb_sql_role_assignment) | resource |
| [azurerm_key_vault.jenkinskv](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.orphaned_resource_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.waf_monitoring_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.db_password](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.db_username](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.logicappsecret](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/key_vault_secret) | resource |
| [azurerm_managed_disk.disk](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/managed_disk) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.managed_identity_operator](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_admin](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.usermi](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/user_assigned_identity) | resource |
| [azuread_group.dts_operations](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principals.pipeline](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principals) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/data-sources/client_config) | data source |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.disks_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.jenkins_key_vault_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/data-sources/subnet) | data source |
| [azurerm_user_assigned_identity.monitoring_mi](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_builtFrom"></a> [builtFrom](#input\_builtFrom) | Name of the GitHub repository this application is being built from. | `string` | n/a | yes |
| <a name="input_container_names"></a> [container\_names](#input\_container\_names) | Database container names for the Cosmosdb account | `list` | <pre>[<br/>  "performance-metrics",<br/>  "pipeline-metrics"<br/>]</pre> | no |
| <a name="input_cosmos_database_name"></a> [cosmos\_database\_name](#input\_cosmos\_database\_name) | Name of the cosmos database. | `string` | `"jenkins"` | no |
| <a name="input_cosmos_subscription_id"></a> [cosmos\_subscription\_id](#input\_cosmos\_subscription\_id) | Subscription to run against for Cosmos DB resources | `string` | n/a | yes |
| <a name="input_enable_workflow"></a> [enable\_workflow](#input\_enable\_workflow) | Enable workflow | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Name of the environment to deploy the resource. | `string` | n/a | yes |
| <a name="input_expiresAfter"></a> [expiresAfter](#input\_expiresAfter) | Expiration date | `string` | `"3000-01-01"` | no |
| <a name="input_jenkins_disk_source_resource_id"></a> [jenkins\_disk\_source\_resource\_id](#input\_jenkins\_disk\_source\_resource\_id) | The ID of existing Managed Disk or Snapshot to copy | `string` | n/a | yes |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Key vault to store secrets in | `string` | n/a | yes |
| <a name="input_key_vault_rg"></a> [key\_vault\_rg](#input\_key\_vault\_rg) | Resource group that holds the Jenkins Key Vault | `string` | `"core-infra-intsvc-rg"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location to deploy the resource | `string` | `"UK South"` | no |
| <a name="input_max_throughput"></a> [max\_throughput](#input\_max\_throughput) | The Maximum throughput of SQL database (RU/s). | `any` | n/a | yes |
| <a name="input_mi_rg"></a> [mi\_rg](#input\_mi\_rg) | Resource group that holds the Jenkins Managed Identity | `any` | n/a | yes |
| <a name="input_operations_groups"></a> [operations\_groups](#input\_operations\_groups) | n/a | `any` | n/a | yes |
| <a name="input_orphaned_resource_application_object_id"></a> [orphaned\_resource\_application\_object\_id](#input\_orphaned\_resource\_application\_object\_id) | DTS Orphaned Resource Cleanup Application Object ID | `string` | `"50cce126-c44a-48bb-9361-5f55868d3182"` | no |
| <a name="input_product"></a> [product](#input\_product) | Name of the product. | `string` | n/a | yes |
| <a name="input_queue_name"></a> [queue\_name](#input\_queue\_name) | Name of the servicebus Queue. | `string` | `"jenkins"` | no |
| <a name="input_servicebus_enable_private_endpoint"></a> [servicebus\_enable\_private\_endpoint](#input\_servicebus\_enable\_private\_endpoint) | Enable private endpoint. | `bool` | `true` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription to run against | `string` | n/a | yes |
| <a name="input_waf_monitoring_application_object_id"></a> [waf\_monitoring\_application\_object\_id](#input\_waf\_monitoring\_application\_object\_id) | WAF Monitoring Application Object ID | `string` | `"414c87c4-9f5a-4fcf-b630-91d1c282ace0"` | no |
| <a name="input_zone_redundant"></a> [zone\_redundant](#input\_zone\_redundant) | Enable Zone redundancy. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->