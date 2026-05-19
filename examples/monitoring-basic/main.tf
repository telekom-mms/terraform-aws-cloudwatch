// examples/monitoring-basic/main.tf

provider "aws" {
  region = "eu-central-1"
}

# CloudWatch Monitoring Module
module "cloudwatch" {
  source = "../../"

  name_prefix = var.name_prefix

  # EC2 Monitoring
  ec2_instance_ids       = var.ec2_instance_ids
  ec2_high_cpu_threshold = var.ec2_high_cpu_threshold
  ec2_low_cpu_threshold  = var.ec2_low_cpu_threshold

  # CloudWatch Logs
  enable_application_logs = var.enable_application_logs
  log_retention_days      = var.log_retention_days

  # SNS Configuration
  sns_email_endpoints = var.sns_email_endpoints

  # Alarm Configuration
  alarm_evaluation_periods  = var.alarm_evaluation_periods
  alarm_datapoints_to_alarm = var.alarm_datapoints_to_alarm
  alarm_period              = var.alarm_period

  # Monitoring Configuration
  enable_detailed_monitoring = var.enable_detailed_monitoring

  # Custom Metrics
  custom_metrics = var.custom_metrics

  # Encryption
  enable_sns_encryption = var.enable_sns_encryption
  kms_key_id            = var.kms_key_id

  tags = var.tags
}
