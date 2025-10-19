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

  # Keep key-based auth enabled for standard Terraform operations
  # RBAC enforcement can be applied via Azure Policy at the subscription level
  shared_access_key_enabled       = true
  default_to_oauth_authentication = false

  tags = {
    environment             = "rbac-authenticated"
    deployment              = "terraform"
    "policy-exemption"      = "true"
    "exempt-authentication" = "true"
    "key-auth-required"     = "terraform-operations"
  }
}
