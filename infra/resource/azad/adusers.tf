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
    count = length(var.users.display_name)
    display_name = var.users.display_name[count.index]
    
    user_principal_name = "${var.users.user_principal_name[count.index]}@${data.azuread_domains.techurtenetdomain.domains.0.domain_name}"
    employee_type = var.users.employee_type[count.index]
    city = var.users.city[count.index]

    mail_nickname = var.users.mail_nickname[count.index]
    password = var.users.password[count.index]  
}