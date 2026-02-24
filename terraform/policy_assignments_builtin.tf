resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  name                 = local.policy_assignment_allowed_locations_name
  policy_definition_id = data.azurerm_policy_definition.allowed_locations.id
  management_group_id  = data.azurerm_management_group.target.id
  enforce              = var.guardrails_enforcement_mode == "Default"
  parameters = jsonencode({
    allowedLocations = {
      value = var.allowed_locations
    }
  })
}


resource "azurerm_management_group_policy_assignment" "require_tag_resources" {
  for_each             = var.required_tags
  name                 = "${local.name_prefix}-require-tag-pa-${each.key}"
  policy_definition_id = data.azurerm_policy_definition.require_tag.id
  management_group_id  = data.azurerm_management_group.target.id
  enforce              = var.guardrails_enforcement_mode == "Default"
  parameters = jsonencode({
    tagName = {
      value = each.key
    }
    tagValue = {
      value = each.value
    }
  })
}

resource "azurerm_management_group_policy_assignment" "require_tag_resource_groups" {
  for_each             = var.required_tags
  name                 = "${local.name_prefix}-require-tag-resource-groups-pa-${each.key}"
  policy_definition_id = data.azurerm_policy_definition.require_tag_on_resource_groups.id
  management_group_id  = data.azurerm_management_group.target.id
  enforce              = var.guardrails_enforcement_mode == "Default"
  parameters = jsonencode({
    tagName = {
      value = each.key
    }
    tagValue = {
      value = each.value
    }
  })
}
