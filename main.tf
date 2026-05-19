// main.tf
# Written by Marc Straubinger - Overhauled for Security-First Best Practices

# SNS Topic for CloudWatch Alarms
# PSA Compliance: Req 3.50-01 (Encryption)
resource "aws_sns_topic" "cloudwatch_alarms" {
  name              = "${var.name_prefix}-cloudwatch-alarms"
  kms_master_key_id = var.enable_sns_encryption ? var.sns_kms_key_id : null

  tags = merge(var.tags, {
    "Name"          = "${var.name_prefix}-cloudwatch-alarms"
    "PSA-Compliant" = "true"
  })
}

# SNS Topic Policy
resource "aws_sns_topic_policy" "allow_cloudwatch" {
  arn    = aws_sns_topic.cloudwatch_alarms.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    sid       = "AllowCloudWatchAlarms"
    effect    = "Allow"
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.cloudwatch_alarms.arn]

    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }

  statement {
    sid       = "EnforceSSL"
    effect    = "Deny"
    actions   = ["sns:*"]
    resources = [aws_sns_topic.cloudwatch_alarms.arn]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

# SNS Email Subscriptions
resource "aws_sns_topic_subscription" "email" {
  for_each  = toset(var.sns_email_endpoints)
  topic_arn = aws_sns_topic.cloudwatch_alarms.arn
  protocol  = "email"
  endpoint  = each.value
}

# CloudWatch Alarms for EC2 Instances
resource "aws_cloudwatch_metric_alarm" "ec2_high_cpu" {
  for_each = toset(var.ec2_instance_ids)

  alarm_name          = "${var.name_prefix}-ec2-${each.key}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_evaluation_periods
  datapoints_to_alarm = var.alarm_datapoints_to_alarm
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.ec2_high_cpu_threshold
  alarm_description   = "EC2 instance ${each.key} high CPU utilization"
  dimensions = {
    InstanceId = each.key
  }

  alarm_actions             = [aws_sns_topic.cloudwatch_alarms.arn]
  insufficient_data_actions = [aws_sns_topic.cloudwatch_alarms.arn]
  ok_actions                = [aws_sns_topic.cloudwatch_alarms.arn]

  tags = merge(var.tags, {
    "Name"          = "${var.name_prefix}-ec2-${each.key}-high-cpu"
    "PSA-Compliant" = "true"
  })
}

# Custom Metric Alarms
resource "aws_cloudwatch_metric_alarm" "custom" {
  for_each = var.custom_metrics

  alarm_name          = "${var.name_prefix}-custom-${each.key}"
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  metric_name         = each.value.metric_name
  namespace           = each.value.namespace
  period              = each.value.period
  statistic           = each.value.statistic
  threshold           = each.value.threshold
  alarm_description   = each.value.description
  dimensions          = each.value.dimensions

  alarm_actions             = [aws_sns_topic.cloudwatch_alarms.arn]
  insufficient_data_actions = [aws_sns_topic.cloudwatch_alarms.arn]
  ok_actions                = [aws_sns_topic.cloudwatch_alarms.arn]

  tags = merge(var.tags, {
    "Name"          = "${var.name_prefix}-custom-${each.key}"
    "PSA-Compliant" = "true"
  })
}

# CloudWatch Logs Group
# PSA Compliance: Req 3.66-05 (Logging obligatory with encryption)
resource "aws_cloudwatch_log_group" "application_logs" {
  count             = var.enable_application_logs ? 1 : 0
  name              = "/aws/app/${var.name_prefix}/logs"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.log_group_kms_key_id

  tags = merge(var.tags, {
    "Name"          = "${var.name_prefix}-application-logs"
    "PSA-Compliant" = "true"
  })
}

# Data source for current AWS account
data "aws_caller_identity" "current" {}
