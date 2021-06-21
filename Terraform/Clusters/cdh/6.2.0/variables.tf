variable "ssh_key" {
  description = "Path to the public key to be used for ssh access to the VM."
  default     = "~/.ssh/id_rsa.pub"
}
variable "user-name" {
  default     = "ubuntu"
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
