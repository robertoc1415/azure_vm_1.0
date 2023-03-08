variable "subscription_id" {
  description = "ID de la suscripción de Azure"
}

variable "client_id" {
  description = "ID del cliente de Azure AD"
}

variable "client_secret" {
  description = "Secreto del cliente de Azure AD"
}

variable "tenant_id" {
  description = "ID del inquilino de Azure AD"
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos de Azure"
}

variable "location" {
  description = "Región de Azure donde se creará la máquina virtual"
  default     = "eastus"
}

variable "virtual_network_name" {
  description = "Nombre de la red virtual de Azure"
  default     = "my-virtual-network"
}

variable "subnet_name" {
  description = "Nombre de la subred de Azure"
  default     = "my-subnet"
}

variable "network_interface_name" {
  description = "Nombre de la interfaz de red de Azure"
  default     = "my-nic"
}

variable "virtual_machine_name" {
  description = "Nombre de la máquina virtual de Azure"
  default     = "my-vm"
}

variable "virtual_machine_size" {
  description = "Tamaño de la máquina virtual de Azure"
  default     = "Standard_D2_v2"
}

variable "admin_username" {
  description = "Nombre de usuario del administrador de la máquina virtual"
  default     = "myusername"
}

variable "admin_password" {
  description = "Contraseña del administrador de la máquina virtual"
  default     = "mypassword"
}
variable "azure_ip_name" {
  description = "The prefix which should be used for all resources in this example"
}
