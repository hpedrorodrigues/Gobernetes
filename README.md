# Kubernetes + GoCD Integration

Just a PoC.

### Prerequisites

- [Minikube][minikube] - v0.28.2+
- [Kubectl][kubectl] - v1.10.1+
- [Docker][docker] - 18.06.0-ce+
- [Envsubst][envsubst] - *

### Manual Settings

Update your `/etc/hosts` file to route requests from poc-gocd.com to minikube
instance.

```bash
echo "$(minikube ip) poc-gocd.com" | sudo tee -a /etc/hosts
```

This is needed because the [ingress.yaml][ingress] file is configured with this
host.

### Private Registry

If you want to use a private registry, just set your environment variable
**KUBE_DOCKER_AUTH** with your base64 credentials and reference the
[private-registry][private-registry] secret in [deployment][gocd-deployment] file.

### Running

Just type `./run.sh` in terminal and finally open the poc-gocd.com address in
browser. :)


[minikube]: https://kubernetes.io/docs/tasks/tools/install-minikube
[kubectl]: https://kubernetes.io/docs/tasks/tools/install-kubectl
[docker]: https://www.docker.com
[envsubst]: https://github.com/a8m/envsubst
[private-registry]: ./orchestrator/templates/private-registry-secret.tpl
[ingress]: ./orchestrator/ingress.yaml#L14
[gocd-deployment]: ./orchestrator/gocd-deployment.yaml
