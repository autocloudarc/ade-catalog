   resource "random_string" "random_suffix" {
     length  = 8
     special = false
     upper   = false
   }

   resource "azurerm_storage_account" "storage" {
     name                     = "${var.storageAccountPrefix}${random_string.random_suffix.result}"
     resource_group_name      = var.resource_group_name
     location                 = var.ade_location
     account_tier             = "Standard"
     account_replication_type = "LRS"
   }
   