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

variable "cosmos_database_name" {
  description = "Name of the cosmos database."
  default     = "jenkins"
}


variable "cosmos_subscription_id" {
  description = "Subscription to run against for Cosmos DB resources"
  type        = string
}

variable "container_names" {
  description = "Database container names for the Cosmosdb account"
  default     = ["performance-metrics", "pipeline-metrics"]
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