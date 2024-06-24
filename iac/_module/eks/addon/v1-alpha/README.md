## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2 |

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
| [aws_iam_policy.aws-mountpoint-s3-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws-ebs-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.aws-efs-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.aws-mountpoint-s3-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.external-secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.vpc-cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.external-secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.aws-ebs-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws-efs-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws-mountpoint-s3-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vpc-cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.external-secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy.aws-ebs-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.aws-efs-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.vpc-cni-ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.aws-ebs-csi-driver-trusted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws-efs-csi-driver-trusted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws-mountpoint-s3-csi-driver-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws-mountpoint-s3-csi-driver-trusted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external-secrets-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external-secrets-trusted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vpc-cni-trusted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adot-addon_version"></a> [adot-addon\_version](#input\_adot-addon\_version) | n/a | `string` | `"v0.94.1-eksbuild.1"` | no |
| <a name="input_adot-enabled"></a> [adot-enabled](#input\_adot-enabled) | n/a | `bool` | `false` | no |
| <a name="input_adot-resolve_conflicts_on_create"></a> [adot-resolve\_conflicts\_on\_create](#input\_adot-resolve\_conflicts\_on\_create) | n/a | `string` | `"OVERWRITE"` | no |
| <a name="input_adot-resolve_conflicts_on_update"></a> [adot-resolve\_conflicts\_on\_update](#input\_adot-resolve\_conflicts\_on\_update) | n/a | `string` | `"NONE"` | no |
| <a name="input_argocd-enabled"></a> [argocd-enabled](#input\_argocd-enabled) | n/a | `bool` | `true` | no |
| <a name="input_argocd-values"></a> [argocd-values](#input\_argocd-values) | n/a | `list(string)` | `[]` | no |
| <a name="input_argocd-version"></a> [argocd-version](#input\_argocd-version) | n/a | `string` | `"6.7.18"` | no |
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
| <a name="input_aws-mountpoint-s3-csi-driver-target_s3"></a> [aws-mountpoint-s3-csi-driver-target\_s3](#input\_aws-mountpoint-s3-csi-driver-target\_s3) | S3 arn list allowed mount. | `set(string)` | `[]` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | EKS cluster name that addons will be deployed. | `string` | n/a | yes |
| <a name="input_eks_oidc_issuer_url"></a> [eks\_oidc\_issuer\_url](#input\_eks\_oidc\_issuer\_url) | EKS OIDC issuer url. | `string` | n/a | yes |
| <a name="input_eks_oidc_provider_arn"></a> [eks\_oidc\_provider\_arn](#input\_eks\_oidc\_provider\_arn) | EKS OIDC Provider arn. | `string` | n/a | yes |
| <a name="input_external-secrets-addon_version"></a> [external-secrets-addon\_version](#input\_external-secrets-addon\_version) | n/a | `string` | `"0.9.19"` | no |
| <a name="input_external-secrets-enabled"></a> [external-secrets-enabled](#input\_external-secrets-enabled) | n/a | `bool` | `true` | no |
| <a name="input_external-secrets-namespace"></a> [external-secrets-namespace](#input\_external-secrets-namespace) | n/a | `string` | `"kube-system"` | no |
| <a name="input_external-secrets-target_secretsmanager"></a> [external-secrets-target\_secretsmanager](#input\_external-secrets-target\_secretsmanager) | Default value is "arn:aws:secretsmanager:$\{data.aws\_region.current.name\}:$\{data.aws\_caller\_identity.current.account\_id\}:*" | `set(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used for the created resources. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | default tags. | `any` | `{}` | no |
| <a name="input_vpc-cni-addon_version"></a> [vpc-cni-addon\_version](#input\_vpc-cni-addon\_version) | n/a | `string` | `"v1.18.2-eksbuild.1"` | no |
| <a name="input_vpc-cni-enabled"></a> [vpc-cni-enabled](#input\_vpc-cni-enabled) | n/a | `bool` | `true` | no |
| <a name="input_vpc-cni-resolve_conflicts_on_create"></a> [vpc-cni-resolve\_conflicts\_on\_create](#input\_vpc-cni-resolve\_conflicts\_on\_create) | n/a | `string` | `"OVERWRITE"` | no |
| <a name="input_vpc-cni-resolve_conflicts_on_update"></a> [vpc-cni-resolve\_conflicts\_on\_update](#input\_vpc-cni-resolve\_conflicts\_on\_update) | n/a | `string` | `"NONE"` | no |

## Outputs

No outputs.
