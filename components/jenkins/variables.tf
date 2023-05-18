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

variable "database" {
  description = "Name of the cosmos database."
  default     = "jenkins"
}

# variable "partition_key" {
#   type        = map(any)
#   description = "Partition Keys for corresponding databases."
#   default = {
#     performance-metrics = "/_partitionKey"
#     pipeline-metrics    = "/_partitionKey"
#   }
# }

variable "cosmos_subscription_id" {
  description = "Subscription to run against"
  type        = string
}

variable "throughput" {
  description = "Throughput for each container"
  default = {
    performance-metrics = 1000
    pipeline-metrics    = 1500
  }
}

# variable "cve_throughput" {
# }
# variable "performance_throughput" {
# }
# variable "pipeline_throughput" {
# }
variable "mi_rg" {
}
