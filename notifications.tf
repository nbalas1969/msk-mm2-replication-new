# ➤ Optional: Slack Notification
resource "null_resource" "notify_slack" {
  count = var.enable_slack_notification ? 1 : 0

  provisioner "local-exec" {
    command = <<EOT
curl -X POST -H 'Content-type: application/json' \
  --data '{"text":"✅ MM2 Connector deployed!\nConnector ARN: ${module.msk_connect.connector_arn}"}' \
  ${var.slack_webhook_url}
EOT
  }

  triggers = {
    connector = module.msk_connect.connector_arn
  }
}

resource "null_resource" "notify_teams" {
  count = var.enable_teams_notification ? 1 : 0

  provisioner "local-exec" {
    command = <<EOT
curl -H "Content-Type: application/json" \
  -d '{"text": "✅ MM2 Connector deployed to AWS!\nConnector ARN: ${module.msk_connect.connector_arn}"}' \
  ${var.teams_webhook_url}
EOT
  }

  triggers = {
    connector = module.msk_connect.connector_arn
  }
}

# ➤ Optional: Email Notification via SNS
resource "aws_sns_topic" "mm2_alerts" {
  count = var.enable_email_notification ? 1 : 0
  name  = "mm2-connector-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  count     = var.enable_email_notification ? 1 : 0
  topic_arn = aws_sns_topic.mm2_alerts[0].arn
  protocol  = "email"
  endpoint  = var.email_address
}

resource "null_resource" "notify_email" {
  count = var.enable_email_notification ? 1 : 0

  provisioner "local-exec" {
    command = "aws sns publish --topic-arn ${aws_sns_topic.mm2_alerts[0].arn} --message '✅ MM2 Connector deployed with ARN: ${module.msk_connect.connector_arn}'"
  }

  triggers = {
    connector = module.msk_connect.connector_arn
  }
}

# ➤ Optional: SSM Parameter Store
resource "aws_ssm_parameter" "connector_arn" {
  count       = var.enable_ssm ? 1 : 0
  name        = "/mm2/connector/arn"
  type        = "String"
  value       = module.msk_connect.connector_arn
  overwrite   = true
  description = "MM2 Connector ARN"
}