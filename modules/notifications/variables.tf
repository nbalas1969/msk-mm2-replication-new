ariable "enable_notifications" {
  type        = bool
  default     = false
}

variable "test_notification_mode" {
  type        = bool
  default     = false
}

variable "enable_teams_notification" {
  type        = bool
  default     = false
}
variable "teams_webhook_url" {
  type        = string
  default     = ""
}

variable "enable_ssm" {
  type        = bool
  default     = false
}

variable "connector_arn" {}
variable "plugin_revision" {}
variable "role_arn" {}