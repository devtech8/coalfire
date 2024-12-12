variable "resource_group_name" {
  description = "Name of the resource group."
}

variable "location" {
  description = "Azure region for the NSG."
}

variable "nsg_name" {
  description = "Name of the NSG."
}

variable "security_rules" {
  description = "List of security rules for the NSG."
  type = list(
    object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })
  )
}
