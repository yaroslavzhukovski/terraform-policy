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
