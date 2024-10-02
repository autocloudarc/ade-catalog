variable "resourceGroupName" {
    type = string
    default = "[resourceGroup().name]"
}   

variable "storageAccountPrefix" {
    type = string
    default = "1sta"
}

variable "logAnalyticsWorkspaceName" {
    type = string
    default = "tfm-law-01"
}

variable "web_nsg" {
    type = string
    default = "web-nsg"
}

variable "app_nsg" {
    type = string
    default = "app-nsg"
}

variable "dta_nsg" {
  type = string
  default = "dta-nsg"
}

variable "location" {
    type = string
    default = "[resourceGroup().location]"
}