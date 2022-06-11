data "azurerm_client_config" "current" {}

provider "azuread" {
  tenant_id = data.azurerm_client_config.current.tenant_id  
}


# Retrieve domain information
data "azuread_domains" "techurtenetdomain" {
  only_initial = true
}

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

resource "azuread_user" "userslist1" {
  count = length(var.userslist.display_name)
  display_name = var.userslist.display_name[count.index]
  user_principal_name = "${var.userslist.user_principal_name[count.index]}@${data.azuread_domains.techurtenetdomain.domains.0.domain_name}"
  employee_type =var.userslist.employee_type [count.index]
  city = var.userslist.city[count.index]
  mail_nickname = var.userslist.mail_nickname[count.index]
  password =var.userslist.password[count.index]
  preferred_language = var.userslist.preferred_language[count.index]
  



} 
  


output "userslistoutput" {
  value = azuread_user.userslist
}