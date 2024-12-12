variable "resource_group_name" {
  description = "Name of the resource group."
}

variable "location" {
  description = "Azure region for the resources."
}

variable "vnet_name" {
  description = "Name of the virtual network."
}

variable "address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets with names and address prefixes."
  type = list(
    object({
      name           = string
      address_prefix = string
    })
  )
}
