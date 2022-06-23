resource "azurerm_role_assignment" "usersassigntorg" {
    count = length(var.role.definition_name) 
    role_definition_name = var.role.definition_name[count.index]
    scope = var.rg[var.role.rgkey[count.index]].id
    principal_id = var.users[var.role.userkey[count.index]].object_id
}