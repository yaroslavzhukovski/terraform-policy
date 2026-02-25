resource "azurerm_management_group_policy_assignment" "org_baseline" {
  name                 = "${local.assignment_prefix}-orgbase"
  display_name         = "Organization Baseline Initiative"
  description          = "Assigns the custom organization baseline initiative at management group scope."
  policy_definition_id = azurerm_management_group_policy_set_definition.org_baseline.id
  management_group_id  = data.azurerm_management_group.target.id
  location             = var.policy_assignment_location
  enforce              = var.guardrails_enforcement_mode == "Default"

  identity {
    type = "SystemAssigned"
  }

  parameters = jsonencode({
    allowed_locations = {
      value = var.allowed_locations
    }
    required_rg_prefix = {
      value = var.resource_group_name_prefix
    }
  })
}
