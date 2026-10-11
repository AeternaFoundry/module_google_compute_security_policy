variable "compute_security_policies" {
  description = <<EOT
Map of compute_security_policies, attributes below
Required:
    - name
Optional:
    - deletion_policy
    - description
    - labels
    - project
    - type
    - adaptive_protection_config (block):
        - layer_7_ddos_defense_config (optional, block):
            - enable (optional)
            - rule_visibility (optional)
            - threshold_configs (optional, block):
                - auto_deploy_confidence_threshold (optional)
                - auto_deploy_expiration_sec (optional)
                - auto_deploy_impacted_baseline_threshold (optional)
                - auto_deploy_load_threshold (optional)
                - detection_absolute_qps (optional)
                - detection_load_threshold (optional)
                - detection_relative_to_baseline_qps (optional)
                - name (required)
                - traffic_granularity_configs (optional, block):
                    - enable_each_unique_value (optional)
                    - type (required)
                    - value (optional)
    - advanced_options_config (block):
        - json_custom_config (optional, block):
            - content_types (required)
        - json_parsing (optional)
        - log_level (optional)
        - request_body_inspection_size (optional)
        - user_ip_request_headers (optional)
    - recaptcha_options_config (block):
        - redirect_site_key (required)
    - rule (block):
        - action (required)
        - description (optional)
        - header_action (optional, block):
            - request_headers_to_adds (required, block):
                - header_name (required)
                - header_value (optional)
        - match (required, block):
            - config (optional, block):
                - src_ip_ranges (required)
            - expr (optional, block):
                - expression (required)
            - expr_options (optional, block):
                - recaptcha_options (required, block):
                    - action_token_site_keys (optional)
                    - session_token_site_keys (optional)
            - versioned_expr (optional)
        - preconfigured_waf_config (optional, block):
            - exclusion (optional, block):
                - request_cookie (optional, block):
                    - operator (required)
                    - value (optional)
                - request_header (optional, block):
                    - operator (required)
                    - value (optional)
                - request_query_param (optional, block):
                    - operator (required)
                    - value (optional)
                - request_uri (optional, block):
                    - operator (required)
                    - value (optional)
                - target_rule_ids (optional)
                - target_rule_set (required)
        - preview (optional)
        - priority (required)
        - rate_limit_options (optional, block):
            - ban_duration_sec (optional)
            - ban_threshold (optional, block):
                - count (required)
                - interval_sec (required)
            - conform_action (required)
            - enforce_on_key (optional)
            - enforce_on_key_configs (optional, block):
                - enforce_on_key_name (optional)
                - enforce_on_key_type (optional)
            - enforce_on_key_name (optional)
            - exceed_action (required)
            - exceed_redirect_options (optional, block):
                - target (optional)
                - type (required)
            - rate_limit_threshold (required, block):
                - count (required)
                - interval_sec (required)
        - redirect_options (optional, block):
            - target (optional)
            - type (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    name            = string
    deletion_policy = optional(string)
    description     = optional(string)
    labels          = optional(map(string))
    project         = optional(string)
    type            = optional(string)
    adaptive_protection_config = optional(object({
      layer_7_ddos_defense_config = optional(object({
        enable          = optional(bool)
        rule_visibility = optional(string)
        threshold_configs = optional(list(object({
          auto_deploy_confidence_threshold        = optional(number)
          auto_deploy_expiration_sec              = optional(number)
          auto_deploy_impacted_baseline_threshold = optional(number)
          auto_deploy_load_threshold              = optional(number)
          detection_absolute_qps                  = optional(number)
          detection_load_threshold                = optional(number)
          detection_relative_to_baseline_qps      = optional(number)
          name                                    = string
          traffic_granularity_configs = optional(list(object({
            enable_each_unique_value = optional(bool)
            type                     = string
            value                    = optional(string)
          })))
        })))
      }))
    }))
    advanced_options_config = optional(object({
      json_custom_config = optional(object({
        content_types = set(string)
      }))
      json_parsing                 = optional(string)
      log_level                    = optional(string)
      request_body_inspection_size = optional(string)
      user_ip_request_headers      = optional(set(string))
    }))
    recaptcha_options_config = optional(object({
      redirect_site_key = string
    }))
    rule = optional(list(object({
      action      = string
      description = optional(string)
      header_action = optional(object({
        request_headers_to_adds = list(object({
          header_name  = string
          header_value = optional(string)
        }))
      }))
      match = object({
        config = optional(object({
          src_ip_ranges = set(string)
        }))
        expr = optional(object({
          expression = string
        }))
        expr_options = optional(object({
          recaptcha_options = object({
            action_token_site_keys  = optional(list(string))
            session_token_site_keys = optional(list(string))
          })
        }))
        versioned_expr = optional(string)
      })
      preconfigured_waf_config = optional(object({
        exclusion = optional(list(object({
          request_cookie = optional(list(object({
            operator = string
            value    = optional(string)
          })))
          request_header = optional(list(object({
            operator = string
            value    = optional(string)
          })))
          request_query_param = optional(list(object({
            operator = string
            value    = optional(string)
          })))
          request_uri = optional(list(object({
            operator = string
            value    = optional(string)
          })))
          target_rule_ids = optional(set(string))
          target_rule_set = string
        })))
      }))
      preview  = optional(bool)
      priority = number
      rate_limit_options = optional(object({
        ban_duration_sec = optional(number)
        ban_threshold = optional(object({
          count        = number
          interval_sec = number
        }))
        conform_action = string
        enforce_on_key = optional(string)
        enforce_on_key_configs = optional(list(object({
          enforce_on_key_name = optional(string)
          enforce_on_key_type = optional(string)
        })))
        enforce_on_key_name = optional(string)
        exceed_action       = string
        exceed_redirect_options = optional(object({
          target = optional(string)
          type   = string
        }))
        rate_limit_threshold = object({
          count        = number
          interval_sec = number
        })
      }))
      redirect_options = optional(object({
        target = optional(string)
        type   = string
      }))
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.rule == null || alltrue([for item in v.rule : (item.header_action == null || (length(item.header_action.request_headers_to_adds) >= 1))])
      )
    ])
    error_message = "Each request_headers_to_adds list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.type == null || (contains(["CLOUD_ARMOR", "CLOUD_ARMOR_EDGE", "CLOUD_ARMOR_INTERNAL_SERVICE"], v.type))
      )
    ])
    error_message = "must be one of: \"CLOUD_ARMOR\", \"CLOUD_ARMOR_EDGE\", \"CLOUD_ARMOR_INTERNAL_SERVICE\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.rule == null || alltrue([for item in v.rule : (item.match.versioned_expr == null || (contains(["SRC_IPS_V1"], item.match.versioned_expr)))])
      )
    ])
    error_message = "must be one of: \"SRC_IPS_V1\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.rule == null || alltrue([for item in v.rule : (item.preconfigured_waf_config == null || (item.preconfigured_waf_config.exclusion == null || alltrue([for item in item.preconfigured_waf_config.exclusion : (item.request_header == null || alltrue([for item in item.request_header : (contains(["EQUALS", "STARTS_WITH", "ENDS_WITH", "CONTAINS", "EQUALS_ANY"], item.operator))]))])))])
      )
    ])
    error_message = "must be one of: \"EQUALS\", \"STARTS_WITH\", \"ENDS_WITH\", \"CONTAINS\", \"EQUALS_ANY\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.rule == null || alltrue([for item in v.rule : (item.preconfigured_waf_config == null || (item.preconfigured_waf_config.exclusion == null || alltrue([for item in item.preconfigured_waf_config.exclusion : (item.request_cookie == null || alltrue([for item in item.request_cookie : (contains(["EQUALS", "STARTS_WITH", "ENDS_WITH", "CONTAINS", "EQUALS_ANY"], item.operator))]))])))])
      )
    ])
    error_message = "must be one of: \"EQUALS\", \"STARTS_WITH\", \"ENDS_WITH\", \"CONTAINS\", \"EQUALS_ANY\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.rule == null || alltrue([for item in v.rule : (item.preconfigured_waf_config == null || (item.preconfigured_waf_config.exclusion == null || alltrue([for item in item.preconfigured_waf_config.exclusion : (item.request_uri == null || alltrue([for item in item.request_uri : (contains(["EQUALS", "STARTS_WITH", "ENDS_WITH", "CONTAINS", "EQUALS_ANY"], item.operator))]))])))])
      )
    ])
    error_message = "must be one of: \"EQUALS\", \"STARTS_WITH\", \"ENDS_WITH\", \"CONTAINS\", \"EQUALS_ANY\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.rule == null || alltrue([for item in v.rule : (item.preconfigured_waf_config == null || (item.preconfigured_waf_config.exclusion == null || alltrue([for item in item.preconfigured_waf_config.exclusion : (item.request_query_param == null || alltrue([for item in item.request_query_param : (contains(["EQUALS", "STARTS_WITH", "ENDS_WITH", "CONTAINS", "EQUALS_ANY"], item.operator))]))])))])
      )
    ])
    error_message = "must be one of: \"EQUALS\", \"STARTS_WITH\", \"ENDS_WITH\", \"CONTAINS\", \"EQUALS_ANY\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.rule == null || alltrue([for item in v.rule : (item.rate_limit_options == null || (contains(["allow"], item.rate_limit_options.conform_action)))])
      )
    ])
    error_message = "must be one of: \"allow\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.rule == null || alltrue([for item in v.rule : (item.rate_limit_options == null || (contains(["redirect", "deny(403)", "deny(404)", "deny(429)", "deny(502)"], item.rate_limit_options.exceed_action)))])
      )
    ])
    error_message = "must be one of: \"redirect\", \"deny(403)\", \"deny(404)\", \"deny(429)\", \"deny(502)\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.rule == null || alltrue([for item in v.rule : (item.rate_limit_options == null || (item.rate_limit_options.enforce_on_key == null || (contains(["ALL", "IP", "HTTP_HEADER", "XFF_IP", "HTTP_COOKIE", "HTTP_PATH", "SNI", "REGION_CODE", "TLS_JA3_FINGERPRINT", "TLS_JA4_FINGERPRINT", "USER_IP", ""], item.rate_limit_options.enforce_on_key))))])
      )
    ])
    error_message = "must be one of: \"ALL\", \"IP\", \"HTTP_HEADER\", \"XFF_IP\", \"HTTP_COOKIE\", \"HTTP_PATH\", \"SNI\", \"REGION_CODE\", \"TLS_JA3_FINGERPRINT\", \"TLS_JA4_FINGERPRINT\", \"USER_IP\", \"\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.rule == null || alltrue([for item in v.rule : (item.rate_limit_options == null || (item.rate_limit_options.enforce_on_key_configs == null || alltrue([for item in item.rate_limit_options.enforce_on_key_configs : (item.enforce_on_key_type == null || (contains(["ALL", "IP", "HTTP_HEADER", "XFF_IP", "HTTP_COOKIE", "HTTP_PATH", "SNI", "REGION_CODE", "TLS_JA3_FINGERPRINT", "TLS_JA4_FINGERPRINT", "USER_IP"], item.enforce_on_key_type)))])))])
      )
    ])
    error_message = "must be one of: \"ALL\", \"IP\", \"HTTP_HEADER\", \"XFF_IP\", \"HTTP_COOKIE\", \"HTTP_PATH\", \"SNI\", \"REGION_CODE\", \"TLS_JA3_FINGERPRINT\", \"TLS_JA4_FINGERPRINT\", \"USER_IP\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.rule == null || alltrue([for item in v.rule : (item.rate_limit_options == null || (item.rate_limit_options.exceed_redirect_options == null || (contains(["EXTERNAL_302", "GOOGLE_RECAPTCHA"], item.rate_limit_options.exceed_redirect_options.type))))])
      )
    ])
    error_message = "must be one of: \"EXTERNAL_302\", \"GOOGLE_RECAPTCHA\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.rule == null || alltrue([for item in v.rule : (item.redirect_options == null || (contains(["EXTERNAL_302", "GOOGLE_RECAPTCHA"], item.redirect_options.type)))])
      )
    ])
    error_message = "must be one of: \"EXTERNAL_302\", \"GOOGLE_RECAPTCHA\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.advanced_options_config == null || (v.advanced_options_config.json_parsing == null || (contains(["DISABLED", "STANDARD", "STANDARD_WITH_GRAPHQL"], v.advanced_options_config.json_parsing)))
      )
    ])
    error_message = "must be one of: \"DISABLED\", \"STANDARD\", \"STANDARD_WITH_GRAPHQL\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.advanced_options_config == null || (v.advanced_options_config.log_level == null || (contains(["NORMAL", "VERBOSE"], v.advanced_options_config.log_level)))
      )
    ])
    error_message = "must be one of: \"NORMAL\", \"VERBOSE\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.advanced_options_config == null || (v.advanced_options_config.request_body_inspection_size == null || (contains(["8KB", "16KB", "32KB", "48KB", "64KB"], v.advanced_options_config.request_body_inspection_size)))
      )
    ])
    error_message = "must be one of: \"8KB\", \"16KB\", \"32KB\", \"48KB\", \"64KB\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.adaptive_protection_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config.rule_visibility == null || (contains(["STANDARD", "PREMIUM"], v.adaptive_protection_config.layer_7_ddos_defense_config.rule_visibility))))
      )
    ])
    error_message = "must be one of: \"STANDARD\", \"PREMIUM\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.adaptive_protection_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs == null || alltrue([for item in v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs : (length(item.name) >= 1 && length(item.name) <= 63)])))
      )
    ])
    error_message = "must be between 1 and 63 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.adaptive_protection_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs == null || alltrue([for item in v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs : (item.auto_deploy_load_threshold == null || (item.auto_deploy_load_threshold >= 0.0))])))
      )
    ])
    error_message = "must be at least 0.0"
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.adaptive_protection_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs == null || alltrue([for item in v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs : (item.auto_deploy_confidence_threshold == null || (item.auto_deploy_confidence_threshold >= 0.0 && item.auto_deploy_confidence_threshold <= 1.0))])))
      )
    ])
    error_message = "must be between 0.0 and 1.0"
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.adaptive_protection_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs == null || alltrue([for item in v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs : (item.auto_deploy_impacted_baseline_threshold == null || (item.auto_deploy_impacted_baseline_threshold >= 0.0 && item.auto_deploy_impacted_baseline_threshold <= 1.0))])))
      )
    ])
    error_message = "must be between 0.0 and 1.0"
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.adaptive_protection_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs == null || alltrue([for item in v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs : (item.auto_deploy_expiration_sec == null || (item.auto_deploy_expiration_sec >= 1 && item.auto_deploy_expiration_sec <= 7776000))])))
      )
    ])
    error_message = "must be between 1 and 7776000"
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.adaptive_protection_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs == null || alltrue([for item in v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs : (item.detection_load_threshold == null || (item.detection_load_threshold >= 0.0))])))
      )
    ])
    error_message = "must be at least 0.0"
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.adaptive_protection_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs == null || alltrue([for item in v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs : (item.detection_absolute_qps == null || (item.detection_absolute_qps >= 0.0))])))
      )
    ])
    error_message = "must be at least 0.0"
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.adaptive_protection_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs == null || alltrue([for item in v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs : (item.detection_relative_to_baseline_qps == null || (item.detection_relative_to_baseline_qps >= 1.0))])))
      )
    ])
    error_message = "must be at least 1.0"
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policies : (
        v.adaptive_protection_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config == null || (v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs == null || alltrue([for item in v.adaptive_protection_config.layer_7_ddos_defense_config.threshold_configs : (item.traffic_granularity_configs == null || alltrue([for item in item.traffic_granularity_configs : (contains(["HTTP_HEADER_HOST", "HTTP_PATH"], item.type))]))])))
      )
    ])
    error_message = "must be one of: \"HTTP_HEADER_HOST\", \"HTTP_PATH\""
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

