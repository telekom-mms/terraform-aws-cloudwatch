// examples/monitoring-basic/outputs.tf

output "sns_topic_arn" {
  description = "ARN of the SNS topic for CloudWatch alarms"
  value       = module.cloudwatch.sns_topic_arn
}

output "sns_topic_name" {
  description = "Name of the SNS topic for CloudWatch alarms"
  value       = module.cloudwatch.sns_topic_name
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = module.cloudwatch.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group"
  value       = module.cloudwatch.cloudwatch_log_group_arn
}

output "cloudwatch_log_stream_name" {
  description = "Name of the CloudWatch log stream"
  value       = module.cloudwatch.cloudwatch_log_stream_name
}

output "ec2_high_cpu_alarm_names" {
  description = "List of EC2 high CPU alarm names"
  value       = module.cloudwatch.ec2_high_cpu_alarm_names
}

output "ec2_low_cpu_alarm_names" {
  description = "List of EC2 low CPU alarm names"
  value       = module.cloudwatch.ec2_low_cpu_alarm_names
}

output "all_alarm_names" {
  description = "List of all CloudWatch alarm names"
  value       = module.cloudwatch.all_alarm_names
}

output "all_alarm_arns" {
  description = "List of all CloudWatch alarm ARNs"
  value       = module.cloudwatch.all_alarm_arns
}
