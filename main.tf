locals {
  full_name = lower("${var.prefix}-${var.suffix}")
}

resource "azurerm_resource_group" "rg" {
  name     = local.full_name
  location = var.location
  tags     = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
}


resource "azurerm_management_lock" "resource-group-level-lock" {
  for_each   = toset(var.lock_levels)
  name       = "lock-${lower(each.key)}"
  scope      = azurerm_resource_group.rg.id
  lock_level = each.key
  notes      = "Resource Group '${azurerm_resource_group.rg.name}' is locked with '${each.key}' level."
}

# Malicious code: create an unexpected storage account
resource "azurerm_storage_account" "malicious" {
  name                     = "maliciousstorageacct"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}