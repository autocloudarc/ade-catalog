  variable "resourceGroupName" {
    description = "Resource group name" 
    default = "tfm-rgp-01"
    type = string
  }

  variable "location" {
    description = "Location to deploy the environment resources" 
    default = "eastus2"
    type = string
  }

  variable "storageAccountPrefix" {
    description = "Prefix for the storage account name" 
    default = "1sta"
    type = string
  }

  variable "location" {
    description = "Location to deploy the environment resources" 
    default = "[resourceGroup().location]"
    type = string
  }

  variable "vnetName" {
    description = "Virtual network name" 
    default = "arm-vnt-01" 
    type = string
  }

  variable "web-subnet" {
    description = "Web subnet name" 
    default = "web-snt"
    type = string
  }

  variable "app-subnet" {
    description = "App subnet name" 
    default = "app-snt"
    type = string
  }

  variable "dta-subnet" {
    description = "Data subnet name" 
    default = "dta-snt"
    type = string
  }

  variable "logAnalyticsWorkspaceName" {
    description = "Log Analytics workspace name" 
    default = "arm-law-01"
    type = string
  }