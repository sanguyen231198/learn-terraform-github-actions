# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.66.0"
    }
  }
    required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_cosmosdb_postgresql_cluster" "example" {
  name                            = "cosmosdb-postgresql"
  resource_group_name             = data.azurerm_resource_group.example.name
  location                        = data.azurerm_resource_group.example.location
  administrator_login_password    = "H@Sh1CoR3!"
  coordinator_storage_quota_in_mb = 131072
  coordinator_vcore_count         = 2
  node_count                      = 2
  node_storage_quota_in_mb        = 131072
  node_vcores                     = 4
  node_public_ip_access_enabled   = true
}

resource "time_sleep" "wait_20_minutes" {
  depends_on = [azurerm_cosmosdb_postgresql_cluster.example]

  create_duration = "1200s"
}

resource "azurerm_cosmosdb_postgresql_cluster" "example-replica" {
  depends_on = [time_sleep.wait_20_minutes]
  count                           = 1
  name                            = "cosmosdb-postgresql-replica-${count.index}"
  resource_group_name             = data.azurerm_resource_group.example.name
  location                        = "eastus2"
  administrator_login_password    = "H@Sh1CoR3!"
  coordinator_storage_quota_in_mb = 131072
  coordinator_vcore_count         = 2
  node_count                      = 2
  node_storage_quota_in_mb        = 131072
  node_vcores                     = 4
  node_public_ip_access_enabled   = true
  source_location                 = data.azurerm_resource_group.example.location
  source_resource_id              = azurerm_cosmosdb_postgresql_cluster.example.id


}

resource "azurerm_cosmosdb_postgresql_node_configuration" "example" {
  name       = "array_nulls"
  cluster_id = azurerm_cosmosdb_postgresql_cluster.example.id
  value      = "on"
}