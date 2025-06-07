resource "azurerm_storage_account" "storage_account" {
  name                     = "satoxicbotstorage${var.environment}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "function_container" {
  name                  = "toxic-bot-function-${var.environment}"
  storage_account_id    = azurerm_storage_account.storage_account.id
  container_access_type = "private"
}

resource "azurerm_service_plan" "service_plan" {
  name                = "sp-toxic-bot-fn-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku_name            = "FC1"
  os_type             = "Linux"
}

resource "azurerm_function_app_flex_consumption" "function_app" {
  name                        = "fn-toxic-bot-${var.environment}"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = var.location
  service_plan_id             = azurerm_service_plan.service_plan.id
  storage_container_type      = "blobContainer"
  storage_container_endpoint  = "${azurerm_storage_account.storage_account.primary_blob_endpoint}${azurerm_storage_container.function_container.name}"
  storage_authentication_type = "StorageAccountConnectionString"
  storage_access_key          = azurerm_storage_account.storage_account.primary_access_key
  runtime_name                = "dotnet-isolated"
  runtime_version             = "9.0"
  maximum_instance_count      = 40
  instance_memory_in_mb       = 2048

  site_config {}
}
