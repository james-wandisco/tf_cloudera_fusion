resource "azurerm_network_interface" "mainnic" {
  name = "nic1-20998jd8qq"
  location = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name = "${local.name}-nic1-ipv4"
    private_ip_address_allocation = "Dynamic"
    subnet_id = data.azurerm_subnet.subnet_1.name
    primary = true
  }
}
resource "azurerm_virtual_machine" "la_manager" {
  name                  = "cdh_manager"
  location              = var.location
  network_interface_ids = ["${azurerm_network_interface.mainnic.id}"]
  resource_group_name   = var.resource_group_name.default
  vm_size               = "Standard_DS3_v2"

#This will delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"

  }

  storage_os_disk {
    name          = "osdisk-1"
    vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.container.name}/osdisk-1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  # Optional data disks
    storage_data_disk {
      name          = "data"
      vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.container.name}/data1.vhd"
      disk_size_gb  = "100"
      create_option = "Empty"
      lun           = 0
    }

  os_profile {
    computer_name  = "manager"
    admin_username = "${var.vm_username_manager}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}


# Master (High Availability)
resource "azurerm_virtual_machine" "la_master" {
  name                  = "cdh_master"
  location              = "${var.location}"
  network_interface_ids = ["${azurerm_network_interface.mainnic.id}"]
  resource_group_name   = var.resource_group_name.default
  vm_size               = "Standard_DS3_v2"

#This will delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"

  }

  storage_os_disk {
    name          = "osdisk-2"
    vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.container.name}/osdisk-2.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  # Optional data disks
    storage_data_disk {
      name          = "data"
      vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.container.name}/data2.vhd"
      disk_size_gb  = "100"
      create_option = "Empty"
      lun           = 0
    }

  os_profile {
    computer_name  = "master"
    admin_username = "${var.vm_username_master}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}


# Worker 1
resource "azurerm_virtual_machine" "la_worker1" {
  name                  = "cdh_worker1"
  location              = "${var.location}"
  network_interface_ids = ["${azurerm_network_interface.mainnic.id}"]
  resource_group_name   = var.resource_group_name.default
  vm_size               = "Standard_DS2_v2"

#This will delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"
  }

  storage_os_disk {
    name          = "osdisk-3"
    vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.container.name}/osdisk-3.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  # Optional data disks
    storage_data_disk {
      name          = "data"
      vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.container.name}/data3.vhd"
      disk_size_gb  = "100"
      create_option = "Empty"
      lun           = 0
    }

  os_profile {
    computer_name  = "worker1"
    admin_username = "${var.vm_username_worker1}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }


}

# Worker 2
resource "azurerm_virtual_machine" "la_worker2" {
  name                  = "cdh_worker2"
  location              = "${var.location}"
  network_interface_ids = ["${azurerm_network_interface.mainnic.id}"]
  resource_group_name   = var.resource_group_name.default
  vm_size               = "Standard_DS2_v2"

#This will delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"
  }

  storage_os_disk {
    name          = "osdisk-4"
    vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.container.name}/osdisk-4.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  # Optional data disks
    storage_data_disk {
      name          = "data"
      vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.container.name}/data4.vhd"
      disk_size_gb  = "100"
      create_option = "Empty"
      lun           = 0
    }

  os_profile {
    computer_name  = "worker2"
    admin_username = "${var.vm_username_worker2}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}

# Worker 3
resource "azurerm_virtual_machine" "la_worker3" {
  name                  = "cdh_worker3"
  location              = "${var.location}"
  network_interface_ids = ["${azurerm_network_interface.mainnic.id}"]
  resource_group_name   = var.resource_group_name.default
  vm_size               = "Standard_DS2_v2"

#This will delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"
  }

  storage_os_disk {
    name          = "osdisk-5"
    vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.container.name}/osdisk-5.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  # Optional data disks
    storage_data_disk {
      name          = "data"
      vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.container.name}/data5.vhd"
      disk_size_gb  = "100"
      create_option = "Empty"
      lun           = 0
    }

  os_profile {
    computer_name  = "worker3"
    admin_username = "${var.vm_username_worker3}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}