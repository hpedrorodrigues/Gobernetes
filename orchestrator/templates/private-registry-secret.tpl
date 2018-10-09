apiVersion: v1
kind: Secret
metadata:
  name: private-registry
  labels:
    app: gocd
    reason: ci
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: ${KUBE_DOCKER_AUTH:='eGFibGF1Cg=='}
