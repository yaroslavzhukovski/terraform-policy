resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  name                 = local.allowed_locs_pa_name
  display_name         = "Allowed Locations"
  description          = "Restricts resource and resource group locations to the approved list."
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
  name                 = "${local.assignment_prefix}-tr-${substr(md5(each.key), 0, 6)}"
  display_name         = "Require Tag On Resources: ${each.key}"
  description          = "Requires tag '${each.key}' with value '${each.value}' on resources."
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
  name                 = "${local.assignment_prefix}-tg-${substr(md5(each.key), 0, 6)}"
  display_name         = "Require Tag On Resource Groups: ${each.key}"
  description          = "Requires tag '${each.key}' with value '${each.value}' on resource groups."
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

resource "azurerm_management_group_policy_assignment" "mcsb" {

  name                 = "${local.assignment_prefix}-mcsb"
  display_name         = "Microsoft Cloud Security Benchmark (MCSB)"
  description          = "Applies the Microsoft Cloud Security Benchmark (MCSB) policy set."
  policy_definition_id = local.builtin_initiatives.mcsb
  management_group_id  = data.azurerm_management_group.target.id
  enforce              = var.guardrails_enforcement_mode == "Default"

}

resource "azurerm_management_group_policy_assignment" "cis" {

  name                 = "${local.assignment_prefix}-cis"
  display_name         = "CIS Microsoft Azure Foundations Benchmark"
  description          = "Applies the CIS Microsoft Azure Foundations Benchmark policy set."
  policy_definition_id = local.builtin_initiatives.cis
  management_group_id  = data.azurerm_management_group.target.id
  enforce              = var.guardrails_enforcement_mode == "Default"

}
