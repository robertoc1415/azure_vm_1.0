output "resource_group_id" {
  value = azurerm_resource_group.main.id
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "subnet_id" {
  value = azurerm_subnet.internal.id
}

output "public_ip" {
  value = azurerm_public_ip.main.ip_address
}
# output "public_ip_address" {
#   value = azurerm_public_ip.main.id
# }

output "network_interface_id" {
  value = azurerm_network_interface.main.id
}

# output "virtual_machine_name" {
#   value = azurerm_virtual_machine.main.name
# }

# output "virtual_machine_size" {
#   value = azurerm_virtual_machine.main.vm_size
# }

# output "os_type" {
#   value = azurerm_virtual_machine.default.storage_image_reference.offer
# }

# output "os_sku" {
#   value = azurerm_virtual_machine.default.storage_image_reference.sku
# }

# output "admin_username" {
#   value = azurerm_virtual_machine.default.os_profile.admin_username
# }

# output "admin_password" {
#   value = azurerm_virtual_machine.default.os_profile.admin_password
# }
