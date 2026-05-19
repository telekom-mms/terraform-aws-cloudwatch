<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Unlicense License][license-shield]][license-url]

<br />

<!-- PROJECT LOGO -->
<div align="center">
  <a href="https://github.com/telekom-mms/terraform-aws-cloudwatch">
    <img src="logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">AWS CloudWatch Monitoring Module</h3>

  <p align="center">
    PSA-compliant CloudWatch module with mandatory log encryption, automated EC2 alarms, and secure SNS notification channels.
    <br />
    <a href="https://github.com/telekom-mms/terraform-aws-cloudwatch"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/telekom-mms/terraform-aws-cloudwatch">View Demo</a>
    ·
    <a href="https://github.com/telekom-mms/terraform-aws-cloudwatch/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/telekom-mms/terraform-aws-cloudwatch/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

## Documentation

Full auto-generated documentation of inputs, outputs, and resources: [TERRAFORM-DOCS.md](TERRAFORM-DOCS.md)

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#security-features">Security Features</a></li>
    <li><a href="#psa-compliance-features">PSA Compliance Features</a></li>
    <li><a href="#outputs">Outputs</a></li>
    <li><a href="#troubleshooting">Troubleshooting</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

This module provides a unified monitoring and logging foundation for AWS environments. it manages CloudWatch Log Groups with mandatory encryption and retention, and creates standard alarms for resource health and performance.

### Features

- **Encrypted Logging**: CloudWatch Log Groups support mandatory SSE-KMS encryption.
- **Automated EC2 Alarms**: Built-in alarms for CPU and system health for a list of instances.
- **Custom Metric Alarms**: flexible support for defining project-specific alarms via map.
- **Secure Notifications**: Encrypted SNS topics for alarm delivery with restrictive policies.
- **Log Retention**: Enforced retention policies to manage log volume and audit compliance.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE -->
## Usage

### Basic Usage

```hcl
module "monitoring" {
  source = "./terraform-aws-cloudwatch"

  name_prefix = "myapp-prod"
  
  enable_application_logs = true
  log_retention_days      = 30
  
  sns_email_endpoints = ["devops@example.com"]
}
```

### Advanced Usage with Custom Metrics

```hcl
module "custom_monitoring" {
  source = "./terraform-aws-cloudwatch"

  name_prefix = "ecommerce"
  
  custom_metrics = {
    high_4xx_errors = {
      metric_name         = "4xxError"
      namespace           = "AWS/ApiGateway"
      statistic           = "Sum"
      threshold           = 100
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 1
      period              = 60
      description         = "High rate of client errors detected"
      dimensions          = { ApiName = "core-api" }
    }
  }
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SECURITY FEATURES -->
## Security Features

- **Mandatory Encryption**: Log Groups and SNS topics are encrypted at rest using KMS.
- **Least Privilege Policy**: SNS policies only allow the `cloudwatch.amazonaws.com` service to publish alarms.
- **SSL Enforcement**: The SNS notification channel enforces HTTPS/SSL for all actions.
- **Retention Guardrails**: Prevents "infinite" log retention by requiring an explicit window (default 30 days).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- PSA COMPLIANCE FEATURES -->
## PSA Compliance Features

This module implements the following PSA compliance features (referencing `01-Strukturierte_PSA_Anforderungen_Allgemein.pdf`):

### Security Controls

- **Req 3.66-05 (Logging)**: Centralized and mandatory logging for all managed applications.
- **Req 3.50-01 (Encryption)**: KMS integration for all stored log data.
- **Req 3.37-04 (Protocolling)**: Logging of security-relevant events via custom metric filters (configurable).
- **Req 9 (Audit Logging)**: All alarm state changes are recorded and notify authorized endpoints.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- TROUBLESHOOTING -->
## Troubleshooting

### Alarms Stuck in INSUFFICIENT_DATA

- Verify that the metric is actually being emitted to CloudWatch.
- Check if the dimensions in your `custom_metrics` configuration match the emitted metric exactly.

### SNS Emails Not Received

- Verify the email addresses in `sns_email_endpoints` have confirmed their subscription.
- Ensure the SNS topic encryption key allows CloudWatch to access it.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/telekom-mms/terraform-aws-cloudwatch.svg?style=for-the-badge
[contributors-url]: https://github.com/telekom-mms/terraform-aws-cloudwatch/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/telekom-mms/terraform-aws-cloudwatch.svg?style=for-the-badge
[forks-url]: https://github.com/telekom-mms/terraform-aws-cloudwatch/network/members
[stars-shield]: https://img.shields.io/github/stars/telekom-mms/terraform-aws-cloudwatch.svg?style=for-the-badge
[stars-url]: https://github.com/telekom-mms/terraform-aws-cloudwatch/stargazers
[issues-shield]: https://img.shields.io/github/issues/telekom-mms/terraform-aws-cloudwatch.svg?style=for-the-badge
[issues-url]: https://github.com/telekom-mms/terraform-aws-cloudwatch/issues
[license-shield]: https://img.shields.io/github/license/telekom-mms/terraform-aws-cloudwatch.svg?style=for-the-badge
[license-url]: https://github.com/telekom-mms/terraform-aws-cloudwatch/blob/master/LICENSE.txt

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

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
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
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
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g., prod, dev, test) | `string` | n/a | yes |
| <a name="input_log_group_kms_key_id"></a> [log\_group\_kms\_key\_id](#input\_log\_group\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data | `string` | `""` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | Number of days to retain logs in CloudWatch | `number` | `30` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names (if not provided, will use project-environment pattern) | `string` | `""` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_sns_email_endpoints"></a> [sns\_email\_endpoints](#input\_sns\_email\_endpoints) | List of email addresses to subscribe to SNS topic | `list(string)` | `[]` | no |
| <a name="input_sns_kms_key_id"></a> [sns\_kms\_key\_id](#input\_sns\_kms\_key\_id) | KMS key ID for SNS topic encryption (if enable\_sns\_encryption=true) | `string` | `"alias/aws/sns"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags for all resources | `map(string)` | `{}` | no |

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