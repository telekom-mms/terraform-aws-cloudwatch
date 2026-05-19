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
