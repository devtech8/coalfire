variable "resource_group_name" {
  description = "Name of the resource group."
}
variable "location" {
  description = "Azure region for the VMs."
}
variable "vm_definitions" {
  description = "List of virtual machine definitions."
  type = list(
    object({
      name      = string
      subnet_id = string
      vm_size   = string
      storage_image_reference = object({
        publisher = string
        offer     = string
        sku       = string
        version   = string
      })
      os_disk = object({
        name              = string
        caching           = string
        create_option     = string
        managed_disk_type = string
        disk_size_gb      = number
      })
      admin_username = string
      admin_password = string
    })
  )
}
