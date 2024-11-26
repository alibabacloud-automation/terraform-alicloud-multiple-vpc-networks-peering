output "vpc_ids" {
  description = "The id of VPCs"
  value       = [for vpc in alicloud_vpc.default : vpc.id]
}

output "vpc_peer_connection_ids" {
  description = "The id of vpc peer connection"
  value       = [for vpc_peer in alicloud_vpc_peer_connection.default : vpc_peer.id]
}

