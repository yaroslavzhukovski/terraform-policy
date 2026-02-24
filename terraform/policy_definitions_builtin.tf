data "azurerm_policy_definition" "allowed_locations" {
  display_name = "Allowed locations"
}

data "azurerm_policy_definition" "require_tag" {
  display_name = "Require a tag and its value on resources"
}

data "azurerm_policy_definition" "require_tag_on_resource_groups" {
  display_name = "Require a tag and its value on resource groups"
}
