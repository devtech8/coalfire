## outputs.tf
output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "storage_account_id" {
  value = module.storage.storage_account_id
}
