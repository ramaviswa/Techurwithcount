resource azurerm_virtual_network  "virtualnetwork" {
    count = length(var.vnet.name)
    name = var.vnet.name[count.index]
    resource_group_name = var.rg[count.index].name
    location = var.rg[count.index].location
    address_space = [var.vnet.address[count.index]]
}