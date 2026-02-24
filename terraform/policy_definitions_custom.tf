resource "azurerm_policy_definition" "rg_naming_convention" {
  name         = "${local.name_prefix}-rg-naming-convention"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Resource Group Naming Convention"
  description  = "Deny creation of resource groups whose names do not start with the required prefix."

  metadata = jsonencode({
    category = "General"
  })

  parameters = jsonencode({
    prefix = {
      type = "String"
      metadata = {
        displayName = "Resource Group name prefix"
        description = "Required prefix for resource group names."
      }
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Resources/subscriptions/resourceGroups"
        },
        {
          field   = "name"
          notLike = "[concat(parameters('prefix'), '*')]"
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}
