// outputs.tf

output "log_group_arn" {
  description = "The ARN of the CloudWatch Log Group"
  value       = try(aws_cloudwatch_log_group.application_logs[0].arn, null)
}

output "log_group_name" {
  description = "The name of the CloudWatch Log Group"
  value       = try(aws_cloudwatch_log_group.application_logs[0].name, null)
}

output "sns_topic_arn" {
  description = "The ARN of the SNS topic used for alarms"
  value       = aws_sns_topic.cloudwatch_alarms.arn
}

output "cpu_alarm_ids" {
  description = "The IDs of the CPU alarms created"
  value       = { for k, v in aws_cloudwatch_metric_alarm.ec2_high_cpu : k => v.id }
}

output "custom_alarm_ids" {
  description = "The IDs of the custom alarms created"
  value       = { for k, v in aws_cloudwatch_metric_alarm.custom : k => v.id }
}

output "low_cpu_alarm_ids" {
  description = "The IDs of the low CPU alarms created"
  value       = { for k, v in aws_cloudwatch_metric_alarm.ec2_low_cpu : k => v.id }
}

output "sns_subscription_arns" {
  description = "Map of SNS email subscription endpoints to their ARNs"
  value       = { for endpoint, subscription in aws_sns_topic_subscription.email : endpoint => subscription.arn }
}

output "alarm_arns" {
  description = "Map of CloudWatch alarm names to their ARNs"
  value = merge(
    { for _, alarm in aws_cloudwatch_metric_alarm.ec2_high_cpu : alarm.alarm_name => alarm.arn },
    { for _, alarm in aws_cloudwatch_metric_alarm.ec2_low_cpu : alarm.alarm_name => alarm.arn },
    { for _, alarm in aws_cloudwatch_metric_alarm.custom : alarm.alarm_name => alarm.arn }
  )
}
