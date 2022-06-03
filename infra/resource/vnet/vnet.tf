resource azurerm_virtual_network  "virtualnetwork" {
    count = length(var.vnet.address)
    name = "${var.vnet.name}-${count.index}"
    resource_group_name = var.resourcegroup[count.index].name
    location = var.resourcegroup[count.index].location
    address_space = [var.vnet.address[count.index]]
}
