data "azurerm_client_config" "current" {}

provider "azuread" {
  tenant_id = data.azurerm_client_config.current.tenant_id  
}


# Retrieve domain information
data "azuread_domains" "techurtenetdomain" {
  only_initial = true
}


/*
resource "azuread_application" "appregistration" {
  display_name = "techurappregistration"
}

resource "azuread_service_principal" "serviceprincipal" {
  application_id = azuread_application.appregistration.id
}*/

resource "azuread_user" "user" {
    user_principal_name = "${var.user.principalname}@${data.azuread_domains.techurtenetdomain.domains.0.domain_name}"
    display_name = var.user.name
    mail_nickname = var.user.nickname
    password = var.user.password  
}

resource "azuread_user" "userslist" {
    count = length(var.users.name)
    name = var.users.name[count.index]
    user_principal_name = var.users.name[count.index]
    employee_type = var.users.name[count.index]
    city = var.users.name[count.index]
    nick_name = var.users.name[count.index]
    password = var.users.name[count.index]

  
}