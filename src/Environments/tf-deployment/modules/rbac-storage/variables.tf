variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "ade_location" {
  type        = string
  description = "Azure region for resources"
}

variable "rbac_storage_account_prefix" {
  type        = string
  description = "Prefix for the RBAC-authenticated storage account name"
  default     = "rbacsta"
}
