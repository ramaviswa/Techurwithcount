##Backenddetails
terraform {
  backend "azurerm" {}
}

## The below lines from 2 to 9 are providers details of terraform
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.6.0"
    }
    azuread = {
      source = "hashicorp/azuread"
  
    }
  }
}

##The below lines for features details for azurerm
provider "azurerm" {
  features {   
  }

}

data "azurerm_client_config" "current" {}

module "techurrg" {
    source = "./resource/resourcegroup"
    rg = var.techurrg
    location = var.techurlocation
}
module "techurvnet" {
  source = "./resource/vnet"
  rg = module.techurrg.resourcegroup1output
  vnet = var.techurvnet
}

module "aduser"{
  source = "./resource/azad"
  user = var.techurusers
  users = var.techuruserslist
}
