resource "alicloud_vpc" "default" {
  for_each = { for i, cidr_block in var.vpcs.cidr_block : cidr_block => i }

  vpc_name        = "${var.vpcs.vpc_name_prefix}-${each.value}"
  cidr_block      = each.key
  ipv6_cidr_block = length(var.vpcs.ipv6_cidr_block) == 0 ? null : var.vpcs.ipv6_cidr_block[each.value]
  enable_ipv6     = true
}

locals {
  vpc_index = { for i, cidr_block in var.vpcs.cidr_block : cidr_block => i }
  vpc_pairs = { for item in flatten([
    for i, vpc_a in alicloud_vpc.default : [
      for j, vpc_b in alicloud_vpc.default :
      {
        peer_key  = "${i}-to-${j}"
        peer_name = "${local.vpc_index[i]}-${local.vpc_index[j]}"
        vpc_a     = vpc_a
        vpc_b     = vpc_b
      }
      if local.vpc_index[i] < local.vpc_index[j]
    ]
  ]) : item.peer_key => item }
}

data "alicloud_account" "current" {}

data "alicloud_regions" "current" {
  current = true
}

resource "alicloud_vpc_peer_connection" "default" {
  for_each = local.vpc_pairs

  peer_connection_name = "pcc-${each.value.peer_name}"
  vpc_id               = each.value.vpc_a.id
  accepting_ali_uid    = data.alicloud_account.current.id
  accepting_region_id  = data.alicloud_regions.current.regions[0].id
  accepting_vpc_id     = each.value.vpc_b.id
  description          = "VPC ${each.value.vpc_a.vpc_name} to VPC ${each.value.vpc_b.vpc_name} Peer Connection"
}


resource "alicloud_route_entry" "route_vpc_a_to_vpc_b_ipv4" {
  for_each = local.vpc_pairs

  destination_cidrblock = each.value.vpc_b.cidr_block
  nexthop_type          = "VpcPeer"
  nexthop_id            = alicloud_vpc_peer_connection.default[each.key].id
  route_table_id        = each.value.vpc_a.route_table_id
}

resource "alicloud_route_entry" "route_vpc_a_to_vpc_b_ipv6" {
  for_each = local.vpc_pairs

  destination_cidrblock = each.value.vpc_b.ipv6_cidr_block
  nexthop_type          = "VpcPeer"
  nexthop_id            = alicloud_vpc_peer_connection.default[each.key].id
  route_table_id        = each.value.vpc_a.route_table_id
}

resource "alicloud_route_entry" "route_vpc_b_to_vpc_a_ipv4" {
  for_each = local.vpc_pairs

  destination_cidrblock = each.value.vpc_a.cidr_block
  nexthop_type          = "VpcPeer"
  nexthop_id            = alicloud_vpc_peer_connection.default[each.key].id
  route_table_id        = each.value.vpc_b.route_table_id
}

resource "alicloud_route_entry" "route_vpc_b_to_vpc_a_ipv6" {
  for_each = local.vpc_pairs

  destination_cidrblock = each.value.vpc_a.ipv6_cidr_block
  nexthop_type          = "VpcPeer"
  nexthop_id            = alicloud_vpc_peer_connection.default[each.key].id
  route_table_id        = each.value.vpc_b.route_table_id
}
