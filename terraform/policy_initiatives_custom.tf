resource "azurerm_management_group_policy_set_definition" "org_baseline" {
  name                = "${local.name_prefix}-org-baseline"
  management_group_id = data.azurerm_management_group.target.id
  policy_type         = "Custom"
  display_name        = "Organization Baseline"
  description         = "Organization baseline initiative combining location, RG naming, and governance tags."

  metadata = jsonencode({
    category = "General"
    version  = "1.0.0"
  })

  parameters = jsonencode({
    allowed_locations = {
      type = "Array"
    }
    required_rg_prefix = {
      type = "String"
    }
  })

  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.allowed_locations.id
    reference_id         = "allowedLocations"
    parameter_values = jsonencode({
      allowedLocations = { value = "[parameters('allowed_locations')]" }
    })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.rg_naming_convention.id
    reference_id         = "resourceGroupNaming"
    parameter_values = jsonencode({
      prefix = { value = "[parameters('required_rg_prefix')]" }
    })
  }

  dynamic "policy_definition_reference" {
    for_each = var.required_tags
    content {
      policy_definition_id = data.azurerm_policy_definition.require_tag_on_resource_groups.id
      reference_id         = "requiredTagOnRG-${substr(md5(policy_definition_reference.key), 0, 6)}"
      parameter_values = jsonencode({
        tagName  = { value = policy_definition_reference.key }
        tagValue = { value = policy_definition_reference.value }
      })
    }
  }
}
