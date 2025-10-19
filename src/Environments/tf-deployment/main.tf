terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.4"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "resource_group_name" {
  type = string
}

variable "ade_location" {
  type = string
}

variable "rbac_storage_account_prefix" {
  description = "Prefix for the RBAC-authenticated storage account name"
  type        = string
  default     = "rbacsta"
}

module "rbac_storage" {
  source                      = "./modules/rbac-storage"
  resource_group_name         = var.resource_group_name
  ade_location                = var.ade_location
  rbac_storage_account_prefix = var.rbac_storage_account_prefix
}

resource "azurerm_network_security_group" "web_nsg" {
  name                = var.web_nsg
  resource_group_name = var.resource_group_name
  location            = var.ade_location
}

resource "azurerm_network_security_group" "app_nsg" {
  name                = var.app_nsg
  resource_group_name = var.resource_group_name
  location            = var.ade_location
}

resource "azurerm_network_security_group" "dta_nsg" {
  name                = var.dta_nsg
  resource_group_name = var.resource_group_name
  location            = var.ade_location
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.logAnalyticsWorkspaceName
  resource_group_name = var.resource_group_name
  location            = var.ade_location
  sku                 = "PerGB2018"
}
output "nsgs" {
  value = {
    web = azurerm_network_security_group.web_nsg.name
    app = azurerm_network_security_group.app_nsg.name
    dta = azurerm_network_security_group.dta_nsg.name
  }
}
output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.log_analytics.name
}

output "rbac_storage_account_name" {
  value       = module.rbac_storage.rbac_storage_account_name
  description = "Name of the RBAC-authenticated storage account"
}

output "rbac_storage_account_id" {
  value       = module.rbac_storage.rbac_storage_account_id
  description = "ID of the RBAC-authenticated storage account"
}

output "rbac_storage_primary_blob_endpoint" {
  value       = module.rbac_storage.rbac_storage_primary_blob_endpoint
  description = "Primary blob endpoint of the RBAC-authenticated storage account"
}
