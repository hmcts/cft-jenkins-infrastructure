variable "env" {
  description = "Name of the target CFT environment for this managed identity."
  type        = string
}

variable "location" {
  description = "Azure location for the managed identity."
  type        = string
  default     = "UK South"
}

variable "subscription_id" {
  description = "Target environment subscription ID for managed identity and subscription-level role assignments."
  type        = string
}

variable "managed_identity_name" {
  description = "Managed identity name."
  type        = string
}

variable "managed_identity_resource_group_name" {
  description = "Resource group where the managed identity exists or will be created."
  type        = string
}

variable "create_identity" {
  description = "Whether to create the managed identity (true) or reference an existing one (false)."
  type        = bool
  default     = true
}

variable "private_dns_subscription_id" {
  description = "Subscription ID that hosts the shared private DNS zones (reform-cft-mgmt)."
  type        = string
  default     = "04d27a32-7a07-48b3-95b8-3c8691e1a263"
}

variable "private_dns_resource_group_name" {
  description = "Resource group in reform-cft-mgmt containing private DNS zones."
  type        = string
  default     = "core-infra-intsvc-rg"
}

variable "tags" {
  description = "Optional tags to apply when creating the managed identity."
  type        = map(string)
  default     = {}
}
