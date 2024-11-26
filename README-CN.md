Terraform module to build multi-VPC Network(Simple Network Interconnection Scenario) for Alibaba Cloud

terraform-alicloud-multiple-vpc-networks-peering 
======================================

[English](https://github.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-peering/blob/main/README.md) | 简体中文

本卓越架构设计重点介绍本在阿里云环境中，如何使用VPC对等连接或转发路由器，针对不同的客户场景和需求，构建高效、安全且高可用的同区域多VPC网络架构。  
简单网络互联场景中，业务单元分别位于独立的VPC中，它们通过VPC对等连接确保了内部网络的连通性及安全性，同时维持着各自的业务隔离。鉴于当前及未来较长时期内无需扩展，这种架构稳定且高效。  
操作流程简介如下:
1. 创建多个VPC
2. VPC之间两两对等连接
3. 创建对等连接路由打通


架构图:

![Diagram](https://raw.githubusercontent.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-peering/main/scripts/diagram.png)


## 用法

创建三个VPC并建立对等连接

```hcl
module "complete" {
  source = "alibabacloud-automation/multiple-vpc-networks-peering/alicloud"

  vpcs = {
    cidr_block = ["10.0.0.0/16", "192.168.0.0/16", "10.4.0.0/16"]
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-peering/tree/main/examples/complete)


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

## 提交问题

如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

## 作者

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## 许可

MIT Licensed. See LICENSE for full details.

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
