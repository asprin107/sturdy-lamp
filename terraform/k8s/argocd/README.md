# Argo CD

Create kubeconfig for EKS

```shell
aws eks update-kubeconfig --region region-code --name my-cluster --profile profile
```

Get initial password

```shell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```