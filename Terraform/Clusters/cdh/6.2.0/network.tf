resource "azurerm_resource_group" "terraform_rg" {
  name      = "${var.resource_group_name}"
  location  = "${var.location}"
}

data "azurerm_subnet" "subnet_1" {
  name = "default"
  virtual_network_name = "SUPPORT-westeurope-vnet"
  resource_group_name = "SUPPORT"
}
