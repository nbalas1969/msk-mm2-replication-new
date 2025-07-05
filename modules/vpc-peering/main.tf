resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.requester_vpc_id
  peer_vpc_id   = var.accepter_vpc_id
  peer_region   = var.peer_region
  peer_owner_id = var.accepter_account_id
  auto_accept   = var.auto_accept
  tags          = var.tags
}

resource "aws_vpc_peering_connection_accepter" "peer_accepter" {
  count                 = var.auto_accept ? 0 : 1
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept                = true
  tags                       = var.tags
}

resource "aws_route" "peer_routes_requester" {
  route_table_id         = var.requester_route_table_id
  destination_cidr_block = var.accepter_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "peer_routes_accepter" {
  route_table_id         = var.accepter_route_table_id
  destination_cidr_block = var.requester_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}