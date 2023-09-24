modulerg = {
  "rg1" = {
    name     = "devops-rg"
    location = "centralindia"
  }
}

vnet = {
  "vnet1" = {
    name                = "g2vnet1"
    location            = "central india"
    resource_group_name = "devops-rg"
    address_space       = ["10.0.0.0/16"]
  },
  "vnet2" = {
    name                = "g2vnet2"
    location            = "central india"
    resource_group_name = "devops-rg-1"
    address_space       = ["10.1.0.0/16"]
  }

}

subnet = {
  "subnet1" = {
    name                 = "g2subnet0"
    resource_group_name  = "devops-rg"
    address_prefixes     = ["10.0.1.0/24"]
    virtual_network_name = "g2vnet1"

  },
  "subnet2" = {
    name                 = "g2subnet1"
    resource_group_name  = "devops-rg"
    address_prefixes     = ["10.0.2.0/24"]
    virtual_network_name = "g2vnet1"

  }



}