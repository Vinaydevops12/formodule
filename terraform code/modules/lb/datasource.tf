data "azurerm_virtual_network" "v-net" {
  name                = var.virtual_network_name
  resource_group_name = var.rg_name
}

data "azurerm_virtual_machine" "nginxvm01" {
  name                = "testvm"
  resource_group_name = var.rg_name
}

data "azurerm_virtual_machine" "nginxvm02" {
  name                = "windowes-vm"
  resource_group_name = var.rg_name
}

data "azurerm_virtual_machine" "nginxvm02" {
    foreach = toset(["testvm", "windowes-vm"])
  name                = "testvm"
  resource_group_name = var.rg_name
}