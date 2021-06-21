resource "azurerm_storage_account" "storage" {
  name          = var.storage_account_name
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
  location      = "${var.location}"
  account_tier    = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name          = "vhds"

  storage_account_name  = "${azurerm_storage_account.storage.name}"
  container_access_type = "private"
}