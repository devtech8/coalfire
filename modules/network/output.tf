output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "subnets" {
  value = azurerm_subnet.this[*]
}
