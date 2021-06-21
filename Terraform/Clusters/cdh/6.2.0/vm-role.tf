# Grant the VM access to the resource group in Azure Resource Manager
# https://docs.microsoft.com/en-gb/azure/active-directory/managed-identities-azure-resources/tutorial-linux-vm-access-arm
resource "azurerm_role_assignment" "main" {
  principal_id = azurerm_virtual_machine.main.identity[0].principal_id
  role_definition_name = "Reader"
  scope = data.azurerm_resource_group.main.id
}

# And grant RW access to the storage accounts
resource "azurerm_role_assignment" "stor1" {
  principal_id = azurerm_virtual_machine.main.identity[0].principal_id
  role_definition_name = "Storage Blob Data Owner"
  scope = module.storage.id
}

resource "azurerm_role_assignment" "stor2" {
  principal_id = azurerm_virtual_machine.main.identity[0].principal_id
  role_definition_name = "Storage Blob Data Owner"
  scope = azurerm_storage_account.adls.id
}
