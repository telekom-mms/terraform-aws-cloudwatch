# AWS CloudWatch Basic Example

This example demonstrates how to use the AWS CloudWatch module to set up monitoring and alerting for your infrastructure.

## Features

- CloudWatch alarms for EC2 instances (CPU utilization)
- SNS topic for notifications
- CloudWatch log group for application logs
- Email notifications for alarms
- Custom metrics support

## Usage

1. Copy this example to your project
2. Update `variables.tf` with your specific values:
   - `ec2_instance_ids`: List of EC2 instance IDs to monitor
   - `sns_email_endpoints`: List of email addresses for notifications
   - `ec2_high_cpu_threshold`: CPU threshold for high CPU alarms
   - `ec2_low_cpu_threshold`: CPU threshold for low CPU alarms

3. Initialize and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Variables

See `variables.tf` for all configurable options.

## Outputs

- `sns_topic_arn`: ARN of the SNS topic
- `cloudwatch_log_group_name`: Name of the log group
- `all_alarm_names`: List of all alarm names

## Requirements

- AWS CLI configured
- Terraform >= 1.0
- Valid email addresses for SNS subscriptions
