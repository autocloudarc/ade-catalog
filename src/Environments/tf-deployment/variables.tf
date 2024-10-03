variable "storageAccountPrefix" {
  description = "Prefix for the storage account name"
  type        = string
  default     = "1sta"
}

variable "web_nsg" {
  description = "Web network security group name"
  type        = string
  default     = "web-nsg"
}

variable "app_nsg" {
  description = "App network security group name"
  type        = string
  default     = "app-nsg"
}

variable "dta_nsg" {
  description = "Data network security group name"
  type        = string
  default     = "dta-nsg"
}

variable "logAnalyticsWorkspaceName" {
  description = "Log Analytics workspace name"
  type        = string
  default     = "arm-law-01"
}
