provider "aws" {
  region = "us-east-1"
}

module "msk_connect" {
  source = "./modules/msk-connect"

  plugin_s3_bucket       = var.plugin_s3_bucket
  plugin_s3_key          = var.plugin_s3_key
  vpc_id                 = var.vpc_id
  vpc_cidr_block         = var.vpc_cidr_block
  private_subnet_ids     = var.private_subnet_ids
  east_bootstrap_servers = var.east_bootstrap_servers
  west_bootstrap_servers = var.west_bootstrap_servers
  msk_connect_role_name  = var.msk_connect_role_name
  tags                   = var.tags
}

module "vpc_peering" {
  source = "./modules/vpc-peering"

  requester_vpc_id      = var.vpc_id
  accepter_vpc_id       = var.peer_vpc_id
  peer_region           = var.peer_region
  accepter_account_id   = var.peer_account_id
  requester_cidr_block  = var.vpc_cidr_block
  accepter_cidr_block   = var.peer_vpc_cidr_block
  auto_accept           = true
  tags                  = var.tags
}

module "mm2_notifications" {
  source = "./modules/notifications"

  enable_notifications      = var.enable_notifications
  test_notification_mode    = var.test_notification_mode

  enable_teams_notification = var.enable_teams_notification
  teams_webhook_url         = var.teams_webhook_url

  enable_ssm                = var.enable_ssm

  connector_arn             = module.msk_connect.connector_arn
  plugin_revision           = module.msk_connect.plugin_revision
  role_arn                  = module.msk_connect.connect_role_arn
}
