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
    resource_group_name = var.rg[var.keyvault.rgkey].location
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
        "Create"
    ]
    storage_permissions = [
        "Get",
        "List",
        "Create"
    ]   
    }
}