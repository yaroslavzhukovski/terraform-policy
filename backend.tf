terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-we-01"
    storage_account_name = "sttfstatef605f3"
    container_name       = "tfstate"
    key                  = "policy/azure-policy-project.tfstate"

    use_azuread_auth = true
    use_oidc         = true
  }
}
