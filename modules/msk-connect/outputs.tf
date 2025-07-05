output "connector_arn" {
  description = "ARN of the MSK Connect MirrorMaker 2 connector"
  value       = aws_mskconnect_connector.mm2_cluster_link.arn
}

output "plugin_revision" {
  description = "Revision of the custom MM2 plugin used"
  value       = aws_mskconnect_custom_plugin.mm2_plugin.latest_revision
}

output "connect_role_arn" {
  description = "IAM role ARN assumed by MSK Connect"
  value       = aws_iam_role.msk_connect_mm2_role.arn
}