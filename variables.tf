variable "vpcs" {
  description = "The parameters of vpcs."
  type = object({
    vpc_name_prefix = optional(string, "vpc-peering")
    cidr_block      = list(string)
    ipv6_cidr_block = optional(list(string), [])
  })
  default = { cidr_block = [] }

  validation {
    condition     = length(var.vpcs.cidr_block) == length(toset(var.vpcs.cidr_block))
    error_message = "The cidr_block must be unique."
  }


  validation {
    condition     = length(var.vpcs.ipv6_cidr_block) == 0 || length(var.vpcs.cidr_block) == length(var.vpcs.ipv6_cidr_block)
    error_message = "The ipv6_cidr_block can be empty or be same length with cidr_block. If you want skip some VPCs, please set ipv6_cidr_block to null."
  }
}
