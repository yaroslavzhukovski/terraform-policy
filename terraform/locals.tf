locals {
  name_prefix         = lower(var.naming_prefix)
  assignment_prefix   = substr(replace(local.name_prefix, "-", ""), 0, 6)
  allowed_locs_pa_name = "${local.assignment_prefix}-aloc"
}
