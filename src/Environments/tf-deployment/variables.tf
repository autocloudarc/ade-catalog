variable "storageAccountPrefix" {
  description = "Prefix for the storage account name"
  type        = string
}

variable "web_nsg" {
  description = "Web network security group name"
  type        = string
}

variable "app_nsg" {
  description = "App network security group name"
  type        = string
}

variable "dta_nsg" {
  description = "Data network security group name"
  type        = string
}

variable "logAnalyticsWorkspaceName" {
  description = "Log Analytics workspace name"
  type        = string
}
