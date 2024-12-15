variable "resource_group_name" {
  description = "Name of the resource group."
}
variable "location" {
  description = "Azure region for the storage account."
}
variable "storage_account_name" {
  description = "Name of the storage account."
}
variable "virtual_network_subnet_ids" {
  description = "List of virtual network subnet IDs."
  type        = list(string)
}
