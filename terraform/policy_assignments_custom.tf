resource "azurerm_management_group_policy_assignment" "rg_naming_convention_pa" {
  name                 = "${local.name_prefix}-rg-naming-convention-pa"
  policy_definition_id = azurerm_policy_definition.rg_naming_convention.id
  management_group_id  = data.azurerm_management_group.target.id
  enforce              = var.guardrails_enforcement_mode == "Default"

  parameters = jsonencode({
    prefix = {
      value = var.resource_group_name_prefix
    }
  })
}
