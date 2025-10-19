resource "random_string" "rbac_storage_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_storage_account" "rbac_storage" {
  name                     = "${var.rbac_storage_account_prefix}${random_string.rbac_storage_suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.ade_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # RBAC-based authentication configuration
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true

  azure_files_authentication {
    directory_type = "AADKERB"
  }

  tags = {
    environment = "rbac-authenticated"
    deployment  = "terraform"
  }
}
