locals {
  name_prefix       = lower(var.naming_prefix)
  assignment_prefix = substr(replace(local.name_prefix, "-", ""), 0, 6)

  builtin_initiatives = {
    mcsb = "/providers/Microsoft.Authorization/policySetDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8"
    cis  = "/providers/Microsoft.Authorization/policySetDefinitions/612b5213-9160-4969-8578-1518bd2a000c"
  }
}
