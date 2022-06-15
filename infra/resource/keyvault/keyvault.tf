provider "azurerm" {
    features {
      key_vault{
          purge_soft_delete_on_destroy = true
      }
    }
  
}

data "azurerm_client_config" "current" {}
 
resource "azurerm_key_vault" "keyvault" {
    name = var.keyvault.name
    location = var.rg[var.keyvault.rgkey].location
    resource_group_name = var.rg[var.keyvault.rgkey].name
    enabled_for_disk_encryption = true
    tenant_id = data.azurerm_client_config.current.tenant_id
    soft_delete_retention_days = 7
    purge_protection_enabled = false

    sku_name = "standard"

    access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = data.azurerm_client_config.current.object_id
    
        key_permissions = [
            "Get",
            "List",
            "Create"
        ]
        secret_permissions = [
            "Get",
            "List",
            "Set"
        ]
        storage_permissions = [
            "Get",
            "List",
            "Backup"
        ]   
    }
}

resource "azurerm_key_vault_access_policy" "amazonkeyvaultacces" {
    key_vault_id = azurerm_key_vault.keyvault.id
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id =  var.users[var.keyvault.userkey].object_id 
    key_permissions = ["Get","List","Create"]
 
    secret_permissions = [ "Get","List" , "Set"]
 }

 resource "azurerm_key_vault_key" "keygenerate" {
     name = var.keyname
     key_vault_id = azurerm_key_vault.keyvault.id
     key_type = var.key_type
     key_size = var.key_size
     key_opts = var.key_opts

   
 }

 resource "azurerm_key_vault_secret" "addkeysecret" {
     name = var.keysecret
     value = var.keyvalue
     key_vault_id = azurerm_key_vault.keyvault.id
   
 }

   


output "keyvaultoutput"{
  value = azurerm_key_vault.keyvault
}