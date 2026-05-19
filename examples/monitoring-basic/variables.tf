// examples/monitoring-basic/variables.tf

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "example"
}

variable "ec2_instance_ids" {
  description = "List of EC2 instance IDs to monitor"
  type        = list(string)
  default     = []
  # Example: ["i-1234567890abcdef0", "i-0987654321fedcba0"]
}

variable "ec2_high_cpu_threshold" {
  description = "CPU utilization threshold for high CPU alarm"
  type        = number
  default     = 80
}

variable "ec2_low_cpu_threshold" {
  description = "CPU utilization threshold for low CPU alarm"
  type        = number
  default     = 10
}

variable "enable_application_logs" {
  description = "Enable application log group creation"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "Number of days to retain logs"
  type        = number
  default     = 30
}

variable "sns_email_endpoints" {
  description = "List of email addresses to receive notifications"
  type        = list(string)
  default     = []
  # Example: ["admin@example.com", "devops@example.com"]
}

variable "alarm_evaluation_periods" {
  description = "Number of periods to evaluate"
  type        = number
  default     = 2
}

variable "alarm_datapoints_to_alarm" {
  description = "Number of datapoints to trigger alarm"
  type        = number
  default     = 2
}

variable "alarm_period" {
  description = "Period in seconds"
  type        = number
  default     = 300
}

variable "enable_detailed_monitoring" {
  description = "Enable detailed monitoring"
  type        = bool
  default     = false
}

variable "custom_metrics" {
  description = "Custom metrics to monitor"
  type = map(object({
    metric_name         = string
    namespace           = string
    statistic           = string
    threshold           = number
    comparison_operator = string
    evaluation_periods  = number
    period              = number
    description         = string
    dimensions          = map(string)
  }))
  default = {
    custom_app_metric = {
      metric_name         = "CustomAppMetric"
      namespace           = "Custom/Application"
      statistic           = "Average"
      threshold           = 100
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 2
      period              = 300
      description         = "Custom application metric alarm"
      dimensions = {
        Environment = "production"
      }
    }
  }
}

variable "enable_sns_encryption" {
  description = "Enable SNS encryption"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ID for encryption"
  type        = string
  default     = "alias/aws/sns"
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "terraform"
    Project     = "monitoring-example"
  }
}
