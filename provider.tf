provider "azurerm" {
 subscription_id = var.usr-subscription-id
 tenant_id = var.usr-tenant-id
 client_id = var.usr-client-id
 client_secret  = var.usr-client-secret
 skip_provider_registratrion = var.usr-skip-provider-registratrion
}