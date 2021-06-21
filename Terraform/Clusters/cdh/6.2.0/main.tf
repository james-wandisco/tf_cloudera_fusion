provider "azurerm" {
  skip_provider_registration = true
  features {}
}

data "external" "env" {
  program = ["python3", "-c", "import json, os; print(json.dumps(dict(os.environ)))"]
}

locals {
  cloud_provider = "azure"
  env = "lab"
  zone = "source"
  shortname = "${local.zone}n1"
  name = "lab-${local.env}-${local.shortname}"
  desc = "lab-Source-Node"
  user = data.external.env.result.USER
}

variable "location" { default = "europe-west1"}
variable "resource_group_name" { default = "SUPPORT-james.hughes1" }

data "azurerm_subnet" "subnet_1" {
  name = "SUPPORT-westeurope-vnet"
  virtual_network_name = "SUPPORT-westeurope-vnet"
  resource_group_name = "SUPPORT"
}
