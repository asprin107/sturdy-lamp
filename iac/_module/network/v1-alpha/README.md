## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_eip.nat_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_route_egress_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_route_egress_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.subnets_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.subnets_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | This used for all resource names. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS vpc region. | `string` | n/a | yes |
| <a name="input_rule"></a> [rule](#input\_rule) | Network creation rule. | <pre>object({<br>    host_cidr = string<br>    subnets = object({<br>      newbits         = number<br>      available_zones = list(string)<br>      pub = object({<br>        amount = number<br>        max    = number<br>      })<br>      prv = object({<br>        amount = number<br>        max    = number<br>      })<br>    })<br>  })</pre> | <pre>{<br>  "host_cidr": "10.0.0.0/16",<br>  "subnets": {<br>    "available_zones": [<br>      "a",<br>      "c"<br>    ],<br>    "newbits": 6,<br>    "prv": {<br>      "amount": 2,<br>      "max": 44<br>    },<br>    "pub": {<br>      "amount": 2,<br>      "max": 20<br>    }<br>  }<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_main_vpc_id"></a> [main\_vpc\_id](#output\_main\_vpc\_id) | VPC id. |
| <a name="output_nat_eips"></a> [nat\_eips](#output\_nat\_eips) | Objects associated with NAT Gateway's public IP. |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | Private subnet ids list. |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | Public subnet ids list. |
