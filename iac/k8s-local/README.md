# k8s-local

## Argo CD

Get initial password

```shell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## Grafana

Get initial password

```shell
kubectl get secret --namespace argocd grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```