terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = ">= 2.0"
        }
    }
}

provider "azurerm" {
    features {}
}

variable "storage_acct_prefix" {
    description = "Prefix for storage account name"
    type        = string
    default     = "storage"
}

variable "vnet_name" {
    description = "Name of the virtual network"
    type        = string
    default     = "my-vnet"
}

variable "log_analytics_workspace_name" {
    description = "Name of the log analytics workspace"
    type        = string
    default     = "my-log-analytics"
}

resource "azurerm_storage_account" "storage" {
    name                     = "${var.storage_acct_prefix}${random_string.random_suffix.result}"
    resource_group_name      = azurerm_resource_group.main.name
    location                 = azurerm_resource_group.main.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
    address_space       = ["192.168.11.0/24"]

    subnet {
        name           = "web"
        address_prefixes = "192.168.11.0/29"
    }

    subnet {
        name           = "app"
        address_prefixes = "192.168.11.8/29"
    }

    subnet {
        name           = "dta"
        address_prefixes = "192.168.11.16/29"
    }
}

resource "azurerm_network_security_group" "web_nsg" {
    name                = "web"
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
}

resource "azurerm_network_security_group" "app_nsg" {
    name                = "app"
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
}

resource "azurerm_network_security_group" "dta_nsg" {
    name                = "dta"
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
    name                = var.log_analytics_workspace_name
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
    sku                 = "PerGB2018"
}

output "storage_account_name" {
    value = azurerm_storage_account.storage.name
}

output "vnet_name" {
    value = azurerm_virtual_network.vnet.name
}

output "subnets" {
    value = {
        web = azurerm_virtual_network.vnet.subnet_web.name
        app = azurerm_virtual_network.vnet.subnet_app.name
        dta = azurerm_virtual_network.vnet.subnet_dta.name
    }
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

output "automation_account_name" {
    value = azurerm_automation_account.automation.name
}
