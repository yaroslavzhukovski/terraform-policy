resource "azurerm_resource_group" "demo" {
  name     = "rg-tf-policy-demo-01"
  location = "Sweden Central"

  tags = {
    ManagedBy = "Terraform"
    Purpose   = "BackendStateProof-02"
  }
}
