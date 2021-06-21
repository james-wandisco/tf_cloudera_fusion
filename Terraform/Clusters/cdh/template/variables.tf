/* All the variables that will be used in the Terraform config
i.e all variables needed without specific values.
The values are specified in the var_values.tfvars file.
*/

variable "ssh_key" {
  description = "Path to the public key to be used for ssh access to the VM."
  default     = "~/.ssh/id_rsa.pub"
}
variable "location" {
  description = "The default Azure region for the resource provisioning"
}

variable "resource_group_name" {
  description = "Resource group name that will contain various resources"
}

variable "vnet_cidr" {
  description = "CIDR block for Virtual Network"
}

variable "subnet1_cidr" {
  description = "CIDR block for Subnet within a Virtual Network"
}

variable "subnet2_cidr" {
  description = "CIDR block for Subnet within a Virtual Network"
}

variable "vm_username_manager" {
  description = "Enter admin username to SSH into Linux VM"
}
 
variable "vm_username_master" {
  description = "Enter admin username to SSH into Linux VM"
}
 
variable "vm_username_worker1" {
  description = "Enter admin username to SSH into Linux VM"
}
 
variable "vm_username_worker2" {
  description = "Enter admin username to SSH into Linux VM"
}
 
variable "vm_username_worker3" {
  description = "Enter admin username to SSH into Linux VM"
}
 
variable "vm_password" {
  description = "Enter admin password to SSH into VM"
}

variable "storage_account_name" {
  description = "Enter a storage account name"
}

