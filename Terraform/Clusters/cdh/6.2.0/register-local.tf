# Azure VM resource doesn't expose the generated VM UUID, and its `id`
# attribute is only based on resource group and name, so it's not unique if
# the VM is re-created with the same name.

resource "random_id" "vmid" {
  keepers = {
    ip = azurerm_network_interface.mainnic.private_ip_address
    id = azurerm_virtual_machine.main.id
  }

  byte_length = 8
}

# Run an Ansible playbook that provisions resources on local dev machine to
# allow access to the Cloud resources.
resource "null_resource" "local-provisioner" {
  triggers = {
    vmid = random_id.vmid.dec
  }

  provisioner "local-exec" {
    command = "ansible-playbook --extra-vars \"cloud_provider=${local.cloud_provider} envname=${local.env} zone=${local.zone} instance_shortname=${local.shortname} instance_name=${local.name} instance_address=${azurerm_network_interface.mainnic.private_ip_address} instance_id=${random_id.vmid.dec} instance_user=${local.user}\" ../../ansible/register-local-dev.yml"
  }
}
