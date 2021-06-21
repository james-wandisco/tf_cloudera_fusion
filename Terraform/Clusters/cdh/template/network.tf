
resource "azurerm_resource_group" "terraform_rg" {
  name      = "${var.resource_group_name}"
  location  = "${var.location}"
}

resource "azurerm_virtual_network" "vnet" {
  name          = "cdh-vnet"
  address_space     = ["${var.vnet_cidr}"]
  location      = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"

}

resource "azurerm_subnet" "subnet_1" {
  name                 = "subnet-1"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${azurerm_resource_group.terraform_rg.name}"
  address_prefixes     = "${var.subnet1_cidr}"
}

resource "azurerm_subnet" "subnet_2" {
  name                 = "subnet-2"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${azurerm_resource_group.terraform_rg.name}"
  address_prefixes     = "${var.subnet2_cidr}"
}

        /*
resource "azurerm_subnet" "subnet_2" {
  name          = "Subnet-1"
  address_prefixes    = "${var.subnet2_cidr}"
  virtual_network_name  = "${azurerm_virtual_network.vnet.name}"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
}
https://github.com/terraform-providers/terraform-provider-azurerm
*/
