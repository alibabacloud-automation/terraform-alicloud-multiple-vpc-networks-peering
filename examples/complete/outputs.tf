output "vpc_ids" {
  description = "The id of VPCs"
  value       = module.complete.vpc_ids
}

output "vpc_peer_connection_ids" {
  description = "The id of vpc peer connection"
  value       = module.complete.vpc_peer_connection_ids
}

