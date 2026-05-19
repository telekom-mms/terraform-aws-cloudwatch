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
