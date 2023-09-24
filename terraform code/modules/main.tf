module "resource_group" {
  source = "./resource_group"
  rg     = var.modulerg
}

module "virtual_network" {

  source     = "./virtual_network"
  vnet = var.vnet
  depends_on = [module.resource_group]
}

 module "subnet" {
   source     = "./subnet"
    subnet  = var.subnet
    depends_on = [module.virtual_network]
 }

 module "virtual machie_linux" {
   source = "./virtual machine_linux"
   
 }

