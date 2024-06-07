## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa-aws-load-balancer-controller"></a> [irsa-aws-load-balancer-controller](#module\_irsa-aws-load-balancer-controller) | ../../../iam/irsa/aws-load-balancer-controller | n/a |
| <a name="module_irsa-cluster-autoscaler"></a> [irsa-cluster-autoscaler](#module\_irsa-cluster-autoscaler) | ../../../iam/irsa/cluster-autoscaler | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.eks_oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cluster-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cluster-vpc-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-node-basic-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-node-cni-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-node-ecr-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.trust-eks-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trust-eks-node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_ssm_parameter.eks_ami_release_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [tls_certificate.eks_certificate_authority](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_nodegroup_ami_type"></a> [eks\_nodegroup\_ami\_type](#input\_eks\_nodegroup\_ami\_type) | EKS default nodegroup AMI type. See https://docs.aws.amazon.com/eks/latest/APIReference/API_Nodegroup.html#AmazonEKS-Type-Nodegroup-amiType | `string` | `"AL2_x86_64"` | no |
| <a name="input_eks_nodegroup_capacity_type"></a> [eks\_nodegroup\_capacity\_type](#input\_eks\_nodegroup\_capacity\_type) | ON\_DEMAND \| SPOT | `string` | `"ON_DEMAND"` | no |
| <a name="input_eks_nodegroup_desired_size"></a> [eks\_nodegroup\_desired\_size](#input\_eks\_nodegroup\_desired\_size) | EKS default nodegroup desired\_size. | `string` | `"1"` | no |
| <a name="input_eks_nodegroup_disk_size"></a> [eks\_nodegroup\_disk\_size](#input\_eks\_nodegroup\_disk\_size) | EKS default nodegroup disk\_size. | `string` | `"200"` | no |
| <a name="input_eks_nodegroup_instance_types"></a> [eks\_nodegroup\_instance\_types](#input\_eks\_nodegroup\_instance\_types) | EKS default nodegroup instance type. | `set(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_eks_nodegroup_max_size"></a> [eks\_nodegroup\_max\_size](#input\_eks\_nodegroup\_max\_size) | EKS default nodegroup max\_size. | `string` | `"4"` | no |
| <a name="input_eks_nodegroup_max_unavailable"></a> [eks\_nodegroup\_max\_unavailable](#input\_eks\_nodegroup\_max\_unavailable) | EKS default nodegroup max\_unavailable. | `string` | `"1"` | no |
| <a name="input_eks_nodegroup_min_size"></a> [eks\_nodegroup\_min\_size](#input\_eks\_nodegroup\_min\_size) | EKS default nodegroup min\_size. | `string` | `"0"` | no |
| <a name="input_eks_security_group_ids"></a> [eks\_security\_group\_ids](#input\_eks\_security\_group\_ids) | EKS cluster security group ids. | `set(string)` | `[]` | no |
| <a name="input_eks_subnet_ids"></a> [eks\_subnet\_ids](#input\_eks\_subnet\_ids) | EKS subnet ids cluster deployed. | `set(string)` | n/a | yes |
| <a name="input_eks_version"></a> [eks\_version](#input\_eks\_version) | Version of EKS Cluster. | `string` | `"1.28"` | no |
| <a name="input_name"></a> [name](#input\_name) | This used for all resource names. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks"></a> [eks](#output\_eks) | n/a |
| <a name="output_eks_cluster_values"></a> [eks\_cluster\_values](#output\_eks\_cluster\_values) | n/a |
