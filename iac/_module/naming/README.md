## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_string.base](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The initial modifier of the name you want to create. | `string` | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name. | `string` | n/a | yes |
| <a name="input_random_length"></a> [random\_length](#input\_random\_length) | Number of digits of the random string to be created. | `number` | `6` | no |
| <a name="input_random_string"></a> [random\_string](#input\_random\_string) | Random string introduced to prevent collisions. If not specified, it will be created. | `string` | `null` | no |
| <a name="input_separator"></a> [separator](#input\_separator) | Separator used to create a name. | `string` | `"-"` | no |
| <a name="input_service"></a> [service](#input\_service) | Service name. | `string` | `null` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | The last modifier of the name you want to create. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | Generated name. |
| <a name="output_random_string"></a> [random\_string](#output\_random\_string) | This is a random string added to prevent collisions when newly created. |
