resource "null_resource" "notify_teams" {
  count = (var.enable_notifications && var.enable_teams_notification) ? 1 : 0

  provisioner "local-exec" {
    command = var.test_notification_mode ? "echo 🚧 [Test Mode] Would notify Teams with ARN: ${var.connector_arn}" : <<EOT
curl -H "Content-Type: application/json" \
  -d "{\"text\": \"✅ MSK MM2 Connector deployed!\nARN: ${var.connector_arn}\"}" \
  ${var.teams_webhook_url}
EOT
  }

  triggers = {
    connector = var.connector_arn
  }
}

resource "aws_ssm_parameter" "connector_arn" {
  count       = (var.enable_notifications && var.enable_ssm) ? 1 : 0
  name        = "/mm2/connector/arn"
  type        = "String"
  value       = var.connector_arn
  overwrite   = true
  description = "Deployed MM2 connector ARN"
}