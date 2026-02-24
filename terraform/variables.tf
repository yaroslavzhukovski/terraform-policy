variable "management_group_name" {
  description = "The name of the management group to which the policy will be assigned."
  type        = string
  default     = "my_landing_zone"
}

variable "allowed_locations" {
  description = "Allowed Azure regions for resources and resource groups."
  type        = list(string)
  default     = ["swedencentral", "swedensouth"]
}

variable "naming_prefix" {
  description = "Prefix used to build stable resource names across environments/subscriptions."
  type        = string
  default     = "platform"
}

variable "required_tags" {
  description = "Required tags and values for the 'Require a tag and its value on resources' policy."
  type        = map(string)
  default = {
    "costcenter"  = "production"
    "environment" = "dev"
    "owner"       = "platform-team"
  }
}

variable "guardrails_enforcement_mode" {
  description = "Enforcement mode for the policy assignments. Can be 'Default' or 'DoNotEnforce'."
  type        = string
  default     = "DoNotEnforce"

  validation {
    condition     = contains(["Default", "DoNotEnforce"], var.guardrails_enforcement_mode)
    error_message = "guardrails_enforcement_mode must be 'Default' or 'DoNotEnforce'."
  }
}

variable "resource_group_name_prefix" {
  description = "Prefix for resource group names created by this project."
  type        = string
  default     = "rg-"

}
