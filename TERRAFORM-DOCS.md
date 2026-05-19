<!-- BEGIN_TF_DOCS -->


## Requirements

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |

## Providers

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.35.1 |

## Resources

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.application_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.ec2_high_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.ec2_low_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.cloudwatch_alarms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.allow_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |

## Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g., prod, dev, test) | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_alarm_datapoints_to_alarm"></a> [alarm\_datapoints\_to\_alarm](#input\_alarm\_datapoints\_to\_alarm) | Number of datapoints that must be breaching to trigger the alarm | `number` | `2` | no |
| <a name="input_alarm_evaluation_periods"></a> [alarm\_evaluation\_periods](#input\_alarm\_evaluation\_periods) | Number of periods over which data is compared to the threshold | `number` | `2` | no |
| <a name="input_alarm_period"></a> [alarm\_period](#input\_alarm\_period) | Period in seconds over which the statistic is applied | `number` | `300` | no |
| <a name="input_custom_metrics"></a> [custom\_metrics](#input\_custom\_metrics) | Custom CloudWatch metrics to create alarms for | <pre>map(object({<br/>    metric_name         = string<br/>    namespace           = string<br/>    threshold           = number<br/>    statistic           = optional(string, "Average")<br/>    comparison_operator = optional(string, "GreaterThanThreshold")<br/>    evaluation_periods  = optional(number, 2)<br/>    datapoints_to_alarm = optional(number)<br/>    period              = optional(number, 300)<br/>    description         = optional(string, "")<br/>    dimensions          = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_ec2_high_cpu_threshold"></a> [ec2\_high\_cpu\_threshold](#input\_ec2\_high\_cpu\_threshold) | CPU utilization threshold for high CPU alarm (percentage) | `number` | `80` | no |
| <a name="input_ec2_instance_ids"></a> [ec2\_instance\_ids](#input\_ec2\_instance\_ids) | List of EC2 instance IDs to monitor | `list(string)` | `[]` | no |
| <a name="input_ec2_low_cpu_threshold"></a> [ec2\_low\_cpu\_threshold](#input\_ec2\_low\_cpu\_threshold) | CPU utilization threshold for low CPU alarm (percentage) | `number` | `10` | no |
| <a name="input_enable_application_logs"></a> [enable\_application\_logs](#input\_enable\_application\_logs) | Enable application log group creation | `bool` | `true` | no |
| <a name="input_enable_detailed_monitoring"></a> [enable\_detailed\_monitoring](#input\_enable\_detailed\_monitoring) | Enable detailed monitoring for EC2 instances | `bool` | `false` | no |
| <a name="input_enable_sns_encryption"></a> [enable\_sns\_encryption](#input\_enable\_sns\_encryption) | Enable encryption for SNS topic | `bool` | `true` | no |
| <a name="input_log_group_kms_key_id"></a> [log\_group\_kms\_key\_id](#input\_log\_group\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data | `string` | `""` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | Number of days to retain logs in CloudWatch | `number` | `30` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names (if not provided, will use project-environment pattern) | `string` | `""` | no |
| <a name="input_sns_email_endpoints"></a> [sns\_email\_endpoints](#input\_sns\_email\_endpoints) | List of email addresses to subscribe to SNS topic | `list(string)` | `[]` | no |
| <a name="input_sns_kms_key_id"></a> [sns\_kms\_key\_id](#input\_sns\_kms\_key\_id) | KMS key ID for SNS topic encryption (if enable\_sns\_encryption=true) | `string` | `"alias/aws/sns"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags for all resources | `map(string)` | `{}` | no |

## Outputs

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alarm_arns"></a> [alarm\_arns](#output\_alarm\_arns) | Map of CloudWatch alarm names to their ARNs |
| <a name="output_cpu_alarm_ids"></a> [cpu\_alarm\_ids](#output\_cpu\_alarm\_ids) | The IDs of the CPU alarms created |
| <a name="output_custom_alarm_ids"></a> [custom\_alarm\_ids](#output\_custom\_alarm\_ids) | The IDs of the custom alarms created |
| <a name="output_log_group_arn"></a> [log\_group\_arn](#output\_log\_group\_arn) | The ARN of the CloudWatch Log Group |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | The name of the CloudWatch Log Group |
| <a name="output_low_cpu_alarm_ids"></a> [low\_cpu\_alarm\_ids](#output\_low\_cpu\_alarm\_ids) | The IDs of the low CPU alarms created |
| <a name="output_sns_subscription_arns"></a> [sns\_subscription\_arns](#output\_sns\_subscription\_arns) | Map of SNS email subscription endpoints to their ARNs |
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | The ARN of the SNS topic used for alarms |
<!-- END_TF_DOCS -->