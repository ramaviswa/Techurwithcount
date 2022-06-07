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