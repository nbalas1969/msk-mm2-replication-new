variable "plugin_s3_bucket" {}
variable "plugin_s3_key" {}
variable "vpc_id" {}
variable "vpc_cidr_block" {}
variable "private_subnet_ids" { type = list(string) }
variable "east_bootstrap_servers" {}
variable "west_bootstrap_servers" {}
variable "msk_connect_role_name" {}
variable "tags" {
  type    = map(string)
  default = {}
}
