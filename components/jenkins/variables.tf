variable "env" {
  description = "Name of the environment to deploy the resource."
  type        = string
}
variable "product" {
  description = "Name of the product."
  type        = string
}

variable "location" {
  description = "Azure location to deploy the resource"
  type        = string
  default     = "UK South"
}

variable "jenkins_disk_source_resource_id" {
  description = "The ID of existing Managed Disk or Snapshot to copy"
  type        = string
  default     = null
}

variable "jenkins_disk_create_option" {
  description = "Creation option for jenkins disk"
  type        = string
}

variable "builtFrom" {
  description = "Name of the GitHub repository this application is being built from."
  type        = string
}

variable "subscription_id" {
  description = "Subscription to run against"
  type        = string
}

variable "key_vault_name" {
  description = "Key vault to store secrets in"
  type        = string
}

variable "key_vault_rg" {
  description = "Resource group that holds the Jenkins Key Vault"
  type        = string
  default     = "core-infra-intsvc-rg"
}

variable "cosmos_subscription_id" {
  description = "Subscription to run against for Cosmos DB resources"
  type        = string
}

variable "cosmos_databases" {
  description = "Cosmos SQL databases and containers to create"
  type = map(object({
    name = string
    containers = map(object({
      partition_key_path = string
      ignore_default_ttl = optional(bool, false)
    }))
  }))
}

variable "max_throughput" {
  description = "The Maximum throughput of SQL database (RU/s)."
}

variable "mi_rg" {
  description = "Resource group that holds the Jenkins Managed Identity"
}

variable "operations_groups" {}

variable "servicebus_enable_private_endpoint" {
  description = "Enable private endpoint."
  default     = true
}
variable "queue_name" {
  default     = "jenkins"
  description = "Name of the servicebus Queue."
}
variable "disk_storage_account_type" {
  description = "Storage account type for the Jenkins managed disk. Use Premium_ZRS for zone-redundant storage (required when nodes span multiple availability zones)."
  type        = string
  default     = "Premium_LRS"
}

variable "zone_redundant" {
  description = "Enable Zone redundancy."
  default     = false
}
variable "enable_workflow" {
  description = "Enable workflow"
  default     = true
}
variable "expiresAfter" {
  description = "Expiration date"
  default     = "3000-01-01"
}

variable "orphaned_resource_application_object_id" {
  description = "DTS Orphaned Resource Cleanup Application Object ID"
  type        = string
  default     = "50cce126-c44a-48bb-9361-5f55868d3182"
}

variable "waf_monitoring_application_object_id" {
  description = "WAF Monitoring Application Object ID"
  type        = string
  default     = "414c87c4-9f5a-4fcf-b630-91d1c282ace0"
}

variable "build_archive_storage" {
  description = "Storage accounts for archived Jenkins builds. The prod account is created in cosmos_subscription_id, in an existing resource group. Leave unset to create none."
  type = object({
    nonprod = object({
      resource_group_name  = string
      storage_account_name = string
      containers           = list(string)
      credential_id        = string
    })
    prod = object({
      resource_group_name  = string
      storage_account_name = string
      containers           = list(string)
      credential_id        = string
    })
  })
  default = null
}

variable "build_archive_account_kind" {
  description = "Kind of the build archive storage accounts."
  type        = string
  default     = "StorageV2"
}

variable "build_archive_account_tier" {
  description = "Tier of the build archive storage accounts."
  type        = string
  default     = "Standard"
}

variable "build_archive_account_replication_type" {
  description = "Replication type of the build archive storage accounts."
  type        = string
  default     = "ZRS"
}

variable "build_archive_allow_nested_items_to_be_public" {
  description = "Whether containers in the build archive storage accounts can be made public."
  type        = bool
  default     = false
}

variable "build_archive_retention_days" {
  description = "Days that deleted blobs and containers in the build archive storage accounts are kept."
  type        = number
  default     = 14
}

variable "build_archive_container_access_type" {
  description = "Access type of the build archive containers."
  type        = string
  default     = "private"
}

variable "build_archive_role_definition_name" {
  description = "Role granted to the Jenkins managed identity on the build archive storage accounts."
  type        = string
  default     = "Storage Blob Data Contributor"
}

variable "build_archive_credential_type" {
  description = "Jenkins credential type set on the build archive Key Vault secrets ('type' tag read by the azure-keyvault plugin)."
  type        = string
  default     = "username"
}
