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
| [aws_eks_addon.adot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.aws-ebs-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.aws-efs-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.aws-mountpoint-s3-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.vpc-cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adot-addon_version"></a> [adot-addon\_version](#input\_adot-addon\_version) | n/a | `string` | `"v0.94.1-eksbuild.1"` | no |
| <a name="input_adot-enabled"></a> [adot-enabled](#input\_adot-enabled) | n/a | `bool` | `false` | no |
| <a name="input_adot-resolve_conflicts_on_create"></a> [adot-resolve\_conflicts\_on\_create](#input\_adot-resolve\_conflicts\_on\_create) | n/a | `string` | `"OVERWRITE"` | no |
| <a name="input_adot-resolve_conflicts_on_update"></a> [adot-resolve\_conflicts\_on\_update](#input\_adot-resolve\_conflicts\_on\_update) | n/a | `string` | `"NONE"` | no |
| <a name="input_aws-ebs-csi-driver-addon_version"></a> [aws-ebs-csi-driver-addon\_version](#input\_aws-ebs-csi-driver-addon\_version) | n/a | `string` | `"v1.31.0-eksbuild.1"` | no |
| <a name="input_aws-ebs-csi-driver-enabled"></a> [aws-ebs-csi-driver-enabled](#input\_aws-ebs-csi-driver-enabled) | n/a | `bool` | `true` | no |
| <a name="input_aws-ebs-csi-driver-resolve_conflicts_on_create"></a> [aws-ebs-csi-driver-resolve\_conflicts\_on\_create](#input\_aws-ebs-csi-driver-resolve\_conflicts\_on\_create) | n/a | `string` | `"OVERWRITE"` | no |
| <a name="input_aws-ebs-csi-driver-resolve_conflicts_on_update"></a> [aws-ebs-csi-driver-resolve\_conflicts\_on\_update](#input\_aws-ebs-csi-driver-resolve\_conflicts\_on\_update) | n/a | `string` | `"NONE"` | no |
| <a name="input_aws-efs-csi-driver-addon_version"></a> [aws-efs-csi-driver-addon\_version](#input\_aws-efs-csi-driver-addon\_version) | n/a | `string` | `"v2.0.3-eksbuild.1"` | no |
| <a name="input_aws-efs-csi-driver-enabled"></a> [aws-efs-csi-driver-enabled](#input\_aws-efs-csi-driver-enabled) | n/a | `bool` | `false` | no |
| <a name="input_aws-efs-csi-driver-resolve_conflicts_on_create"></a> [aws-efs-csi-driver-resolve\_conflicts\_on\_create](#input\_aws-efs-csi-driver-resolve\_conflicts\_on\_create) | n/a | `string` | `"OVERWRITE"` | no |
| <a name="input_aws-efs-csi-driver-resolve_conflicts_on_update"></a> [aws-efs-csi-driver-resolve\_conflicts\_on\_update](#input\_aws-efs-csi-driver-resolve\_conflicts\_on\_update) | n/a | `string` | `"NONE"` | no |
| <a name="input_aws-mountpoint-s3-csi-driver-addon_version"></a> [aws-mountpoint-s3-csi-driver-addon\_version](#input\_aws-mountpoint-s3-csi-driver-addon\_version) | n/a | `string` | `"v1.5.1-eksbuild.1"` | no |
| <a name="input_aws-mountpoint-s3-csi-driver-enabled"></a> [aws-mountpoint-s3-csi-driver-enabled](#input\_aws-mountpoint-s3-csi-driver-enabled) | n/a | `bool` | `false` | no |
| <a name="input_aws-mountpoint-s3-csi-driver-resolve_conflicts_on_create"></a> [aws-mountpoint-s3-csi-driver-resolve\_conflicts\_on\_create](#input\_aws-mountpoint-s3-csi-driver-resolve\_conflicts\_on\_create) | n/a | `string` | `"OVERWRITE"` | no |
| <a name="input_aws-mountpoint-s3-csi-driver-resolve_conflicts_on_update"></a> [aws-mountpoint-s3-csi-driver-resolve\_conflicts\_on\_update](#input\_aws-mountpoint-s3-csi-driver-resolve\_conflicts\_on\_update) | n/a | `string` | `"NONE"` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | EKS cluster name that addons will be deployed. | `string` | n/a | yes |
| <a name="input_vpc-cni-addon_version"></a> [vpc-cni-addon\_version](#input\_vpc-cni-addon\_version) | n/a | `string` | `"v1.18.2-eksbuild.1"` | no |
| <a name="input_vpc-cni-enabled"></a> [vpc-cni-enabled](#input\_vpc-cni-enabled) | n/a | `bool` | `true` | no |
| <a name="input_vpc-cni-resolve_conflicts_on_create"></a> [vpc-cni-resolve\_conflicts\_on\_create](#input\_vpc-cni-resolve\_conflicts\_on\_create) | n/a | `string` | `"OVERWRITE"` | no |
| <a name="input_vpc-cni-resolve_conflicts_on_update"></a> [vpc-cni-resolve\_conflicts\_on\_update](#input\_vpc-cni-resolve\_conflicts\_on\_update) | n/a | `string` | `"NONE"` | no |

## Outputs

No outputs.
