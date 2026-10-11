resource "google_compute_security_policy" "compute_security_policies" {
  for_each = var.compute_security_policies

  name            = each.value.name
  deletion_policy = each.value.deletion_policy
  description     = each.value.description
  labels          = each.value.labels
  project         = each.value.project
  type            = each.value.type

  dynamic "adaptive_protection_config" {
    for_each = each.value.adaptive_protection_config != null ? [each.value.adaptive_protection_config] : []
    content {
      dynamic "layer_7_ddos_defense_config" {
        for_each = adaptive_protection_config.value.layer_7_ddos_defense_config != null ? [adaptive_protection_config.value.layer_7_ddos_defense_config] : []
        content {
          enable          = layer_7_ddos_defense_config.value.enable
          rule_visibility = layer_7_ddos_defense_config.value.rule_visibility
          dynamic "threshold_configs" {
            for_each = layer_7_ddos_defense_config.value.threshold_configs != null ? layer_7_ddos_defense_config.value.threshold_configs : []
            content {
              auto_deploy_confidence_threshold        = threshold_configs.value.auto_deploy_confidence_threshold
              auto_deploy_expiration_sec              = threshold_configs.value.auto_deploy_expiration_sec
              auto_deploy_impacted_baseline_threshold = threshold_configs.value.auto_deploy_impacted_baseline_threshold
              auto_deploy_load_threshold              = threshold_configs.value.auto_deploy_load_threshold
              detection_absolute_qps                  = threshold_configs.value.detection_absolute_qps
              detection_load_threshold                = threshold_configs.value.detection_load_threshold
              detection_relative_to_baseline_qps      = threshold_configs.value.detection_relative_to_baseline_qps
              name                                    = threshold_configs.value.name
              dynamic "traffic_granularity_configs" {
                for_each = threshold_configs.value.traffic_granularity_configs != null ? threshold_configs.value.traffic_granularity_configs : []
                content {
                  enable_each_unique_value = traffic_granularity_configs.value.enable_each_unique_value
                  type                     = traffic_granularity_configs.value.type
                  value                    = traffic_granularity_configs.value.value
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "advanced_options_config" {
    for_each = each.value.advanced_options_config != null ? [each.value.advanced_options_config] : []
    content {
      dynamic "json_custom_config" {
        for_each = advanced_options_config.value.json_custom_config != null ? [advanced_options_config.value.json_custom_config] : []
        content {
          content_types = json_custom_config.value.content_types
        }
      }
      json_parsing                 = advanced_options_config.value.json_parsing
      log_level                    = advanced_options_config.value.log_level
      request_body_inspection_size = advanced_options_config.value.request_body_inspection_size
      user_ip_request_headers      = advanced_options_config.value.user_ip_request_headers
    }
  }

  dynamic "recaptcha_options_config" {
    for_each = each.value.recaptcha_options_config != null ? [each.value.recaptcha_options_config] : []
    content {
      redirect_site_key = recaptcha_options_config.value.redirect_site_key
    }
  }

  dynamic "rule" {
    for_each = each.value.rule != null ? each.value.rule : []
    content {
      action      = rule.value.action
      description = rule.value.description
      dynamic "header_action" {
        for_each = rule.value.header_action != null ? [rule.value.header_action] : []
        content {
          dynamic "request_headers_to_adds" {
            for_each = header_action.value.request_headers_to_adds
            content {
              header_name  = request_headers_to_adds.value.header_name
              header_value = request_headers_to_adds.value.header_value
            }
          }
        }
      }
      match {
        dynamic "config" {
          for_each = rule.value.match.config != null ? [rule.value.match.config] : []
          content {
            src_ip_ranges = config.value.src_ip_ranges
          }
        }
        dynamic "expr" {
          for_each = rule.value.match.expr != null ? [rule.value.match.expr] : []
          content {
            expression = expr.value.expression
          }
        }
        dynamic "expr_options" {
          for_each = rule.value.match.expr_options != null ? [rule.value.match.expr_options] : []
          content {
            recaptcha_options {
              action_token_site_keys  = expr_options.value.recaptcha_options.action_token_site_keys
              session_token_site_keys = expr_options.value.recaptcha_options.session_token_site_keys
            }
          }
        }
        versioned_expr = rule.value.match.versioned_expr
      }
      dynamic "preconfigured_waf_config" {
        for_each = rule.value.preconfigured_waf_config != null ? [rule.value.preconfigured_waf_config] : []
        content {
          dynamic "exclusion" {
            for_each = preconfigured_waf_config.value.exclusion != null ? preconfigured_waf_config.value.exclusion : []
            content {
              dynamic "request_cookie" {
                for_each = exclusion.value.request_cookie != null ? exclusion.value.request_cookie : []
                content {
                  operator = request_cookie.value.operator
                  value    = request_cookie.value.value
                }
              }
              dynamic "request_header" {
                for_each = exclusion.value.request_header != null ? exclusion.value.request_header : []
                content {
                  operator = request_header.value.operator
                  value    = request_header.value.value
                }
              }
              dynamic "request_query_param" {
                for_each = exclusion.value.request_query_param != null ? exclusion.value.request_query_param : []
                content {
                  operator = request_query_param.value.operator
                  value    = request_query_param.value.value
                }
              }
              dynamic "request_uri" {
                for_each = exclusion.value.request_uri != null ? exclusion.value.request_uri : []
                content {
                  operator = request_uri.value.operator
                  value    = request_uri.value.value
                }
              }
              target_rule_ids = exclusion.value.target_rule_ids
              target_rule_set = exclusion.value.target_rule_set
            }
          }
        }
      }
      preview  = rule.value.preview
      priority = rule.value.priority
      dynamic "rate_limit_options" {
        for_each = rule.value.rate_limit_options != null ? [rule.value.rate_limit_options] : []
        content {
          ban_duration_sec = rate_limit_options.value.ban_duration_sec
          dynamic "ban_threshold" {
            for_each = rate_limit_options.value.ban_threshold != null ? [rate_limit_options.value.ban_threshold] : []
            content {
              count        = ban_threshold.value.count
              interval_sec = ban_threshold.value.interval_sec
            }
          }
          conform_action = rate_limit_options.value.conform_action
          enforce_on_key = rate_limit_options.value.enforce_on_key
          dynamic "enforce_on_key_configs" {
            for_each = rate_limit_options.value.enforce_on_key_configs != null ? rate_limit_options.value.enforce_on_key_configs : []
            content {
              enforce_on_key_name = enforce_on_key_configs.value.enforce_on_key_name
              enforce_on_key_type = enforce_on_key_configs.value.enforce_on_key_type
            }
          }
          enforce_on_key_name = rate_limit_options.value.enforce_on_key_name
          exceed_action       = rate_limit_options.value.exceed_action
          dynamic "exceed_redirect_options" {
            for_each = rate_limit_options.value.exceed_redirect_options != null ? [rate_limit_options.value.exceed_redirect_options] : []
            content {
              target = exceed_redirect_options.value.target
              type   = exceed_redirect_options.value.type
            }
          }
          rate_limit_threshold {
            count        = rate_limit_options.value.rate_limit_threshold.count
            interval_sec = rate_limit_options.value.rate_limit_threshold.interval_sec
          }
        }
      }
      dynamic "redirect_options" {
        for_each = rule.value.redirect_options != null ? [rule.value.redirect_options] : []
        content {
          target = redirect_options.value.target
          type   = redirect_options.value.type
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

