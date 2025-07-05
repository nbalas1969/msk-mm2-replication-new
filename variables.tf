variable "plugin_s3_bucket" {
  type        = string
  description = "S3 bucket name that stores the MM2 plugin JAR"
}

variable "plugin_s3_key" {
  type        = string
  description = "S3 object key for the MM2 plugin JAR"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID used by MSK Connect to access the cluster"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block for security group ingress"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for MSK Connect deployment"
}

variable "east_bootstrap_servers" {
  type        = string
  description = "Bootstrap servers for the source MSK cluster"
}

variable "west_bootstrap_servers" {
  type        = string
  description = "Bootstrap servers for the destination MSK cluster"
}

variable "msk_connect_role_name" {
  type        = string
  description = "Name of the IAM role MSK Connect assumes"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Common tags to apply to resources"
}

variable "peer_vpc_id" {}
variable "peer_vpc_cidr_block" {}
variable "peer_region" {}
variable "peer_account_id" {}
variable "requester_route_table_id" {}
variable "accepter_route_table_id" {}
variable "enable_teams_notification" { type = bool default = false }
variable "enable_email_notification" { type = bool default = false }
variable "enable_ssm" ( type = bool default = false }

variable "slack_webhook_url" {
  type        = string
  description = "Slack webhook for MM2 deployment alerts"
  default     = ""
}

variable "email_address" {
  type        = string
  description = "Email to receive deployment notifications via SNS"
  default     = ""
}

variable "enable_teams_notification" {
  type        = bool
  default     = false
  description = "Enable sending deployment notifications to Microsoft Teams"
}

variable "teams_webhook_url" {
  type        = string
  default     = ""
  description = "Webhook URL for your Microsoft Teams channel"
}