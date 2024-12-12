resource "azurerm_virtual_machine" "this" {
  count               = length(var.vm_definitions)
  name                = var.vm_definitions[count.index].name
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [
    var.vm_definitions[count.index].subnet_id
  ]
  vm_size = var.vm_definitions[count.index].vm_size

  storage_image_reference {
    publisher = var.vm_definitions[count.index].storage_image_reference.publisher
    offer     = var.vm_definitions[count.index].storage_image_reference.offer
    sku       = var.vm_definitions[count.index].storage_image_reference.sku
    version   = var.vm_definitions[count.index].storage_image_reference.version
  }

  os_disk {
    name              = var.vm_definitions[count.index].os_disk.name
    caching           = var.vm_definitions[count.index].os_disk.caching
    create_option     = var.vm_definitions[count.index].os_disk.create_option
    managed_disk_type = var.vm_definitions[count.index].os_disk.managed_disk_type
    disk_size_gb      = var.vm_definitions[count.index].os_disk.disk_size_gb
  }

  admin_username = var.vm_definitions[count.index].admin_username
  admin_password = var.vm_definitions[count.index].admin_password
}
