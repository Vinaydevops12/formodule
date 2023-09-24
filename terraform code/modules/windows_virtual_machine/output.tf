output "public_ip" {
  value = [
    for virtual_machine in azurerm_public_ip.winpip : virtual_machine.ip_address
  ]
}