data "azurerm_policy_definition" "allowed_locations" {
  display_name = "Allowed locations"
}

data "azurerm_policy_definition" "require_tag_on_resource_groups" {
  display_name = "Require a tag on resource groups"
}

data "azurerm_policy_definition" "inherit_tag_from_resource_group_if_missing" {
  display_name = "Inherit a tag from the resource group if missing"
}
