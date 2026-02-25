data "azurerm_resource_group" "location_exempt_rg" {
  name = "rg-prodstyle-main-sc-530rki"
}

resource "azurerm_resource_group_policy_exemption" "location_exemption" {
  name                            = "ex-allowedlocations-rg-prodstyle-20260228"
  resource_group_id               = data.azurerm_resource_group.location_exempt_rg.id
  policy_assignment_id            = azurerm_management_group_policy_assignment.org_baseline.id
  policy_definition_reference_ids = ["allowedLocations"]
  exemption_category              = "Waiver"
  display_name                    = "Exemption for allowed locations policy definition"
  description                     = "Approved by Platform Team for Service X regional dependency. Ticket SEC-42. Remove by 2026-02-28."
  expires_on                      = "2026-02-28T23:59:59Z"
}

resource "azurerm_resource_group_policy_exemption" "rg_naming_exemption" {
  name                            = "ex-rgnaming-rg-prodstyle-20260228"
  resource_group_id               = data.azurerm_resource_group.location_exempt_rg.id
  policy_assignment_id            = azurerm_management_group_policy_assignment.org_baseline.id
  policy_definition_reference_ids = ["resourceGroupNaming"]
  exemption_category              = "Waiver"
  display_name                    = "Exemption for resource group naming policy definition"
  description                     = "Approved by Platform Team for legacy RG migration. Ticket SEC-43. Remove by 2026-02-28."
  expires_on                      = "2026-02-28T23:59:59Z"
}
