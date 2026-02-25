resource "azurerm_role_assignment" "org_baseline_modify_roles" {
  for_each = {
    for role_id in data.azurerm_policy_definition.inherit_tag_from_resource_group_if_missing.role_definition_ids :
    role_id => role_id
  }

  scope              = data.azurerm_management_group.target.id
  role_definition_id = each.value
  principal_id       = azurerm_management_group_policy_assignment.org_baseline.identity[0].principal_id
  principal_type     = "ServicePrincipal"
}
