## main.tf
module "resource_group" {
  source   = "./modules/resource_group"
  name     = "poc-resource-group"
  location = "East US"
}

module "network" {
  source              = "./modules/network"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vnet_name           = "poc-vnet"
  address_space       = ["10.0.0.0/16"]
  subnets = [
    { name = "subnet1", address_prefix = "10.0.0.0/24" },
    { name = "subnet2", address_prefix = "10.0.1.0/24" },
    { name = "subnet3", address_prefix = "10.0.2.0/24" },
    { name = "subnet4", address_prefix = "10.0.3.0/24" }
  ]
}

module "nsg" {
  source              = "./modules/nsg"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  nsg_name            = "nsg-sub1"
  security_rules = [
    {
      name                       = "Allow-SSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "*"
    }
  ]
}

module "virtual_machines" {
  source              = "./modules/virtual_machine"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vm_definitions = [
    {
      name      = "vm1"
      subnet_id = module.network.subnets[0].id
      vm_size   = "Standard_DS1_v2"
      storage_image_reference = {
        publisher = "RedHat"
        offer     = "RHEL"
        sku       = "8-lvm"
        version   = "latest"
      }
      os_disk = {
        name              = "osdisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
        disk_size_gb      = 256
      }
      admin_username = "azureuser"
      admin_password = "Password1234!"
    },
    {
      name      = "vm2"
      subnet_id = module.network.subnets[0].id
      vm_size   = "Standard_DS1_v2"
      storage_image_reference = {
        publisher = "RedHat"
        offer     = "RHEL"
        sku       = "8-lvm"
        version   = "latest"
      }
      os_disk = {
        name              = "osdisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
        disk_size_gb      = 256
      }
      admin_username = "azureuser"
      admin_password = "Password1234!"
    }
  ]
}

module "storage" {
  source                     = "./modules/storage"
  resource_group_name        = module.resource_group.name
  location                   = module.resource_group.location
  storage_account_name       = "pocstorageacct"
  virtual_network_subnet_ids = module.network.subnets.*.id
}
