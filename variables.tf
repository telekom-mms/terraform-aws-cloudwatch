// variables.tf

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., prod, dev, test)"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource names (e.g., 'myapp-prod')"
  type        = string
}

variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
}

variable "ec2_instance_ids" {
  description = "List of EC2 instance IDs to monitor"
  type        = list(string)
  default     = []
}

variable "ec2_high_cpu_threshold" {
  description = "CPU utilization threshold for high CPU alarm (percentage)"
  type        = number
  default     = 80
}

variable "ec2_low_cpu_threshold" {
  description = "CPU utilization threshold for low CPU alarm (percentage)"
  type        = number
  default     = 10
}

variable "enable_application_logs" {
  description = "Enable application log group creation"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "Number of days to retain logs in CloudWatch"
  type        = number
  default     = 30
  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653], var.log_retention_days)
    error_message = "Log retention days must be one of: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653."
  }
}

variable "log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  type        = string
  default     = ""
}

variable "sns_email_endpoints" {
  description = "List of email addresses to subscribe to SNS topic"
  type        = list(string)
  default     = []
}

variable "alarm_evaluation_periods" {
  description = "Number of periods over which data is compared to the threshold"
  type        = number
  default     = 2
}

variable "alarm_datapoints_to_alarm" {
  description = "Number of datapoints that must be breaching to trigger the alarm"
  type        = number
  default     = 2
}

variable "alarm_period" {
  description = "Period in seconds over which the statistic is applied"
  type        = number
  default     = 300
}

variable "enable_detailed_monitoring" {
  description = "Enable detailed monitoring for EC2 instances"
  type        = bool
  default     = false
}

variable "custom_metrics" {
  description = "Custom CloudWatch metrics to create alarms for"
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
  default = {}
}

variable "enable_sns_encryption" {
  description = "Enable encryption for SNS topic"
  type        = bool
  default     = true
}

variable "sns_kms_key_id" {
  description = "KMS key ID for SNS topic encryption (if enable_sns_encryption=true)"
  type        = string
  default     = "alias/aws/sns"
}
