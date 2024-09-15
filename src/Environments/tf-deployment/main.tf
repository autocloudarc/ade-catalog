terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 4.2"
        }
    }
}

provider "azurerm" {
    features {}
}

data "azurerm_resource_group" "main" {
	name     = "dev-prj-01-env-tfm-12 (dev-prj-01)"
	location = "eastus2"
}

resource "random_string" "random_suffix" {
  length  = 8
  special = false
  upper = false
}


resource "azurerm_storage_account" "storage" {
    name                     = "${var.storageAccountPrefix}${random_string.random_suffix.result}"
    resource_group_name      = azurerm_resource_group.main.name
    location                 = azurerm_resource_group.main.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
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
    name                = var.logAnalyticsWorkspaceName
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
    sku                 = "PerGB2018"
}

output "storage_account_name" {
    value = azurerm_storage_account.storage.name
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
