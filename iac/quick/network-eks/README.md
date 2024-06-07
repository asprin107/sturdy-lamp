## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_addon"></a> [addon](#module\_addon) | ../../_module/eks/addon/v1-alpha | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | ../../_module/eks/cluster/v1-alpha | n/a |
| <a name="module_naming"></a> [naming](#module\_naming) | ../../_module/naming | n/a |
| <a name="module_network"></a> [network](#module\_network) | ../../_module/network/v1-alpha | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project"></a> [project](#input\_project) | Project name. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region name. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service name. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_naming"></a> [naming](#output\_naming) | Object associated with naming convention. |
| <a name="output_network"></a> [network](#output\_network) | Result of created network resources. |
