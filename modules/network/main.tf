resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}
resource "azurerm_subnet" "this" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  address_prefix       = var.subnets[count.index].address_prefix
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
}
