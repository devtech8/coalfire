output "vm_ids" {
  value = azurerm_virtual_machine.this[*].id
}
