# # Configuración de las credenciales de Azure
# provider "azurerm" {
#   subscription_id = var.subscription_id
#   client_id       = var.client_id
#   client_secret   = var.client_secret
#   tenant_id       = var.tenant_id
#   features {
#   }
# }

# # Crear un grupo de recursos de Azure
# resource "azurerm_resource_group" "default" {
#   name     = var.resource_group_name
#   location = var.location
# }

# # Crear una red virtual en Azure
# resource "azurerm_virtual_network" "my_vnet" {
#   name                = var.virtual_network_name
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.default.location
#   resource_group_name = azurerm_resource_group.default.name
# }

# # Crear una subred
# resource "azurerm_subnet" "default" {
#   name                 = var.subnet_name
#   address_prefixes     = ["10.0.1.0/24"]
#   resource_group_name  = azurerm_resource_group.default.name
#   virtual_network_name = azurerm_virtual_network.my_vnet.name
# }

# # Crear una interfaz de red
# resource "azurerm_network_interface" "default" {
#   name                = var.network_interface_name
#   location            = azurerm_resource_group.default.location
#   resource_group_name = azurerm_resource_group.default.name

#   ip_configuration {
#     name                          = "my-ip-config"
#     subnet_id                     = azurerm_subnet.default.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# # Agregar reglas de puerto de entrada en el recurso de grupo de seguridad de red
# resource "azurerm_network_security_group" "default" {
#   name                = "my-nsg"
#   location            = azurerm_resource_group.default.location
#   resource_group_name = azurerm_resource_group.default.name

#   security_rule {
#     name                       = "allow-ssh"
#     priority                   = 1001
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "allow-http"
#     priority                   = 1002
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "80"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# # Crear una máquina virtual en Azure
# resource "azurerm_virtual_machine" "default" {
#   name                  = var.virtual_machine_name
#   location              = azurerm_resource_group.default.location
#   resource_group_name   = azurerm_resource_group.default.name
#   network_interface_ids = [azurerm_network_interface.default.id]
#   vm_size               = var.virtual_machine_size

#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "16.04-LTS"
#     version   = "latest"
#   }

#   storage_os_disk {
#     name              = "myosdisk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   os_profile {
#     computer_name  = "my-vm"
#     admin_username = var.admin_username
#     admin_password = var.admin_password
#   }

#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }


provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "main" {
  name                = var.azure_ip_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = var.network_interface_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}
# Agregar reglas de puerto de entrada en el recurso de grupo de seguridad de red
resource "azurerm_network_security_group" "main" {
  name                = "my-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-http"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_linux_virtual_machine" "main" {
  name                            = var.virtual_machine_name
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_F2"
  admin_username                  = "carlos"
  admin_password                  = "Fkf63dLay12c!"
  disable_password_authentication = false
  
  network_interface_ids      = [azurerm_network_interface.main.id]
  # network_security_group_id  = azurerm_network_security_group.main.id

  # provision_vm_agent         = true
  # network_interface_ids = [
  #   azurerm_network_interface.main.id,
  # ]
  # network_security_group_id = azurerm_network_security_group.main.id

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "ls -la /tmp",
  #   ]

  #   connection {
  #     host     = self.public_ip_address
  #     user     = self.admin_username
  #     password = self.admin_password
  #   }
  # }
}