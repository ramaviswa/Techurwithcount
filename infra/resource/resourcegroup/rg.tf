resource "azurerm_resource_group" "resource" {
    count = var.rg.count
    name = "${var.rg.name}-${count.index}"
    location = var.location 
}

output "resourcegroup1output" {
    value = azurerm_resource_group.resource
}