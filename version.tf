terraform {
  cloud {
  organization = "terraform-sanguyen"
  workspaces {
    name = "learn-terraform-github-actions-test"
    }
  }
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.66.0"
    }
  }
}