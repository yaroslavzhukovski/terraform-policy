terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "stterraformstate"
    container_name       = "tfstate"
    key                  = "policy/azure-policy-project.tfstate"

    use_azuread_auth = true
    use_oidc         = true
  }
}
