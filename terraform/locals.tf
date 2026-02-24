locals {
  name_prefix                              = lower(var.naming_prefix)
  policy_assignment_allowed_locations_name = "${local.name_prefix}-allowed-locations-pa"
}
