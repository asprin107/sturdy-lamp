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
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | environment map | `object({})` | `{}` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | lambda function entrypoint in source code. | `string` | `"lambda_function.lambda_handler"` | no |
| <a name="input_lambda_description"></a> [lambda\_description](#input\_lambda\_description) | description for lambda function | `string` | n/a | yes |
| <a name="input_lambda_role_arn"></a> [lambda\_role\_arn](#input\_lambda\_role\_arn) | Role ARN for lambda. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | base name about all resources | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda function runtime .Available values - https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime | `string` | `"python3.12"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | security group ids for lambda function | `list(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | subnet ids for lambda deployed | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | tags object | `object({})` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | n/a |
| <a name="output_lambda_name"></a> [lambda\_name](#output\_lambda\_name) | n/a |
