# terraform {
#  backend "azurerm" {
#    resource_group_name  = "UltimateProject-rg"
#    storage_account_name = "hamidterraform"
#    container_name       = "tfbackend"
#    key                  = "prod.terraform.tfstate"
#  }
#}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}