resource "azurerm_resource_group" "resource" {
    count = length (var.rg.name)
    name = var.rg.name[count.index]
    location = var.location 
}

output "resourcegroup1output" {
    value = azurerm_resource_group.resource
}