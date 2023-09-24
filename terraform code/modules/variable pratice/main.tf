resource "azurerm_resource_group" "terraformrg1" {
  name     = var.rg
  location = var.location
  tags = {
    code = "variable ke baare me jaantan tha"
}
}

resource "azurerm_resource_group" "terr1" {
  name     = "vedika"
  location = var.location
  tags = {
    code = "variable ke baare me jaantan tha"
}
}