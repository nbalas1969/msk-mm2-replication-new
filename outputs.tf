output "msk_connector_arn" {
  description = "ARN of the MSK Connect MirrorMaker 2 connector"
  value       = module.msk_connect.connector_arn
}

output "msk_plugin_revision" {
  description = "Revision ID of the custom MM2 plugin"
  value       = module.msk_connect.plugin_revision
}

output "msk_connect_role" {
  description = "IAM role assigned to MSK Connect"
  value       = module.msk_connect.connect_role_arn
}