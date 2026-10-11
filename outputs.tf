output "compute_security_policies_id" {
  description = "Map of id values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no id are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.id if v.id != null && length(v.id) > 0 }
}
output "compute_security_policies_adaptive_protection_config" {
  description = "Map of adaptive_protection_config values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no adaptive_protection_config are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => one(v.adaptive_protection_config) if v.adaptive_protection_config != null && length(v.adaptive_protection_config) > 0 }
}
output "compute_security_policies_advanced_options_config" {
  description = "Map of advanced_options_config values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no advanced_options_config are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => one(v.advanced_options_config) if v.advanced_options_config != null && length(v.advanced_options_config) > 0 }
}
output "compute_security_policies_deletion_policy" {
  description = "Map of deletion_policy values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no deletion_policy are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.deletion_policy if v.deletion_policy != null && length(v.deletion_policy) > 0 }
}
output "compute_security_policies_description" {
  description = "Map of description values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no description are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.description if v.description != null && length(v.description) > 0 }
}
output "compute_security_policies_effective_labels" {
  description = "Map of effective_labels values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no effective_labels are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.effective_labels if v.effective_labels != null && length(v.effective_labels) > 0 }
}
output "compute_security_policies_fingerprint" {
  description = "Map of fingerprint values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no fingerprint are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.fingerprint if v.fingerprint != null && length(v.fingerprint) > 0 }
}
output "compute_security_policies_label_fingerprint" {
  description = "Map of label_fingerprint values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no label_fingerprint are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.label_fingerprint if v.label_fingerprint != null && length(v.label_fingerprint) > 0 }
}
output "compute_security_policies_labels" {
  description = "Map of labels values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no labels are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.labels if v.labels != null && length(v.labels) > 0 }
}
output "compute_security_policies_name" {
  description = "Map of name values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no name are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.name if v.name != null && length(v.name) > 0 }
}
output "compute_security_policies_project" {
  description = "Map of project values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no project are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.project if v.project != null && length(v.project) > 0 }
}
output "compute_security_policies_recaptcha_options_config" {
  description = "Map of recaptcha_options_config values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no recaptcha_options_config are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => one(v.recaptcha_options_config) if v.recaptcha_options_config != null && length(v.recaptcha_options_config) > 0 }
}
output "compute_security_policies_rule" {
  description = "Map of rule values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no rule are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.rule if v.rule != null && length(v.rule) > 0 }
}
output "compute_security_policies_self_link" {
  description = "Map of self_link values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no self_link are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.self_link if v.self_link != null && length(v.self_link) > 0 }
}
output "compute_security_policies_terraform_labels" {
  description = "Map of terraform_labels values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no terraform_labels are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.terraform_labels if v.terraform_labels != null && length(v.terraform_labels) > 0 }
}
output "compute_security_policies_type" {
  description = "Map of type values across all compute_security_policies, keyed the same as var.compute_security_policies except keys with no type are omitted"
  value       = { for k, v in google_compute_security_policy.compute_security_policies : k => v.type if v.type != null && length(v.type) > 0 }
}

