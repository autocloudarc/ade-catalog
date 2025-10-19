output "rbac_storage_account_name" {
  value       = azurerm_storage_account.rbac_storage.name
  description = "Name of the RBAC-authenticated storage account"
}

output "rbac_storage_account_id" {
  value       = azurerm_storage_account.rbac_storage.id
  description = "ID of the RBAC-authenticated storage account"
}

output "rbac_storage_primary_blob_endpoint" {
  value       = azurerm_storage_account.rbac_storage.primary_blob_endpoint
  description = "Primary blob endpoint of the RBAC-authenticated storage account"
}
