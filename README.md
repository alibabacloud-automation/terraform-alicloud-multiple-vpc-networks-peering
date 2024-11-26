Terraform module to build multi-VPC Network(Simple Network Interconnection Scenario) for Alibaba Cloud

terraform-alicloud-multiple-vpc-networks-peering 
======================================

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-peering/blob/main/README-CN.md)

This Well-Architecture design emphasizes how to use VPC peering or transit routers in the Alibaba Cloud  to build an efficient, secure, and highly available multi-VPC network architecture within the same region, tailored to different customer scenarios and needs.  
In simple network interconnection scenarios, the business units are located in separate VPCs, and they ensure internal network connectivity and security through VPC peering, while maintaining their own business isolation. Given that there is no need for expansion in the current and foreseeable future, this architecture is stable and efficient.  
The operation procedure is briefly as follows:
1. Create multiple VPCs
2. Establish pairwise VPC peering connections
3. Set up routing for the peering connections

Architecture Diagram:

![Diagram](https://raw.githubusercontent.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-peering/main/scripts/diagram.png)


## Usage

create three VPCs and establish pairwise VPC peering connections.

```hcl
module "complete" {
  source = "alibabacloud-automation/multiple-vpc-networks-peering/alicloud"

  vpcs = {
    cidr_block = ["10.0.0.0/16", "192.168.0.0/16", "10.4.0.0/16"]
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-peering/tree/main/examples/complete)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_route_entry.route_vpc_a_to_vpc_b_ipv4](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.route_vpc_a_to_vpc_b_ipv6](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.route_vpc_b_to_vpc_a_ipv4](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.route_vpc_b_to_vpc_a_ipv6](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_peer_connection.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc_peer_connection) | resource |
| [alicloud_account.current](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_regions.current](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpcs"></a> [vpcs](#input\_vpcs) | The parameters of vpcs. | <pre>object({<br>    vpc_name_prefix = optional(string, "vpc-peering")<br>    cidr_block      = list(string)<br>    ipv6_cidr_block = optional(list(string), [])<br>  })</pre> | <pre>{<br>  "cidr_block": []<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_ids"></a> [vpc\_ids](#output\_vpc\_ids) | The id of VPCs |
| <a name="output_vpc_peer_connection_ids"></a> [vpc\_peer\_connection\_ids](#output\_vpc\_peer\_connection\_ids) | The id of vpc peer connection |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
