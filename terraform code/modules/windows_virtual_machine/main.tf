data "azurerm_subnet" "vn1" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

#keyvault for keyvault name
data "azurerm_key_vault" "sec1" {
  name                = var.keyvault_name
  resource_group_name = var.rg_name
}
#keyvault for password
data "azurerm_key_vault_secret" "sec2" {
  
  name         = var.key1
  key_vault_id = data.azurerm_key_vault.sec1.id
}
data "azurerm_key_vault_secret" "passwd" {
  
  name         =var.key2

  key_vault_id = data.azurerm_key_vault.sec1.id
}


resource "azurerm_network_interface" "win-nic" {
  for_each            = var.virtual_machine
  name                = each.value.nic
  location            = each.value.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.vn1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.winpip[each.key].id
  }
}
# pip using for new = ip_address
resource "azurerm_public_ip" "winpip" {
  for_each            = var.virtual_machine
  name                = each.value.public_ip
  resource_group_name = var.rg_name
  location            = each.value.location
  allocation_method   = "Static"


}


resource "azurerm_windows_virtual_machine" "winvm" {
  for_each            = var.virtual_machine
  name                = each.value.name
  resource_group_name = var.rg_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.win-nic[each.key].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}