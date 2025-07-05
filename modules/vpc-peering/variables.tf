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