# Deploy a simple http server with ssh on k8s

## Terraform

Change the ssh key in the file and then execute the following.

```bash
export MNEMONICS="words"
export NETWORK=test
terraform apply -parallelism=1 --auto-approve
```

The public ip should show up, ssh to this ip then download the cluster config file from the remote's `/etc/rancher/k3s/k3s.yaml` to `/tmp/config.yaml` locally. Then change the ip `127.0.0.1` to the public ip printed in the terraform output.

Deploy a DNS record pointing to the ip of the cluster (printed by terraform). The one used in this example is `simple-http-app.omar.gridtesting.xyz`.

## Docker

This can be skipped if there's already a docker image pushed. A new image can be build and pushed as described [here](./docker/README.md). The image name is used in the k8s yaml file as the pod's image.

Note that the image must listen on 0.0.0.0, and it must serve http (not https).

## K8s

- Replace the ssh key with the desired one.
- Replace the image to the one to be used.
- Change the port 8080 to the port this image listens on (the image omarelawady/ubuntu-ssh listens on 8080)
- Change the domain in the ingress to the domain created pointing to the cluster ip.
- To generate a real certificate, change `traefik.ingress.kubernetes.io/router.tls.certresolver: default` in the ingress annotation to `traefik.ingress.kubernetes.io/router.tls.certresolver: le` (beware of certificate limits)

Deploy by executing:
```bash
export KUBECONFIG=/tmp/config.yaml
kubectl apply -f deployment.yaml
```

The defined resources can be changed by modifying `deployment.yaml` and then executing `kubectl apply -f deployment.yaml` again. If the changes can't be applied in-place, the resource must be deleted then the file applied again. For example, the command `kubectl delete pod http-app` can be used to delete the pod.

## SSH

To create a port-forward to the pod:
```bash
kubectl port-forward http-app 2546:22
```

To access the pod using ssh:
```bash
ssh root@127.0.0.1 -p 2546
```

## How to access the pod without ssh

SSH is a non-standard way to access the pod. Instead, to access the pod without port forwarding, this command can be used:
```bash
kubectl exec -ti http-app -- /bin/bash
```
