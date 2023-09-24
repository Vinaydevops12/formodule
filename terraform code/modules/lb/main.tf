
resource "azurerm_public_ip" "pipcode" {
  name                = "PIP_code"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "loadb" {
  name                = "lb_code"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.pipcode.id
  }
}

resource "azurerm_lb_backend_address_pool" "BackEndAddressPool" {
  loadbalancer_id = azurerm_lb.loadb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_backend_address_pool_address" "backendnginx01" {
  name                    = "testvm"
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackEndAddressPool.id
  virtual_network_id      = data.azurerm_virtual_network.v-net.id
  ip_address              = data.azurerm_virtual_machine.v-net.private_ip_address
}

resource "azurerm_lb_backend_address_pool_address" "backendnginx02" {
  name                    = "windowes-vm"
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackEndAddressPool.id
  virtual_network_id      = data.azurerm_virtual_network.v-net.id
  ip_address              = data.azurerm_virtual_machine.v-net.private_ip_address
}

resource "azurerm_lb_probe" "nginxprobe" {
  loadbalancer_id = azurerm_lb.loadb
  name            = "http-port"
  port            = 80
}

resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = azurerm_lb.loadb
  name                           = "NginxRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.BackEndAddressPool.id]
  probe_id                       = azurerm_lb_probe.nginxprobe.id
}