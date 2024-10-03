terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 4.3"
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

resource "random_string" "random_suffix" {
    length  = 8
    special = false
    upper = false
}

resource "azurerm_storage_account" "storage" {
    name                     = "${var.storageAccountPrefix}${random_string.random_suffix.result}"
    resource_group_name      = var.resource_group_name
    location                 = var.ade_location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_network_security_group" "web_nsg" {
    name                = var.web_nsg
    resource_group_name      = var.resource_group_name
    location                 = var.ade_location
}

resource "azurerm_network_security_group" "app_nsg" {
    name                = var.app_nsg
    resource_group_name      = var.resource_group_name
    location                 = var.ade_location
}

resource "azurerm_network_security_group" "dta_nsg" {
    name                = var.dta_nsg
    resource_group_name      = var.resource_group_name
    location                 = var.ade_location
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
    name                = var.logAnalyticsWorkspaceName
    resource_group_name      = var.resource_group_name
    location                 = var.ade_location
    sku                 = "PerGB2018"
}

output "storage_account_name" {
    value = module.storage.storage_account_name
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
