#!/usr/bin/env bash
set -eou pipefail

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"
gocdserver_dir="${current_dir}/containers/gocd-server/helpers/"
gocdandroidagent_dir="${current_dir}/containers/gocd-agent/android/helpers/"

if [[ "$(minikube status | grep 'minikube:' | awk '{ print $2 }')" != "Running" ]] || [[ "$(minikube status | grep 'cluster:' | awk '{ print $2 }')" != "Running" ]]
then
  echo "Starting minikube"
  minikube start \
    --vm-driver hyperkit \
    --bootstrapper kubeadm \
    --memory 4096 \
    --cpus 3 \
    --disk-size 20g
fi

eval $(minikube docker-env)

source "${gocdserver_dir}/build.sh"
source "${gocdandroidagent_dir}/build.sh"

if [[ -n "${KUBE_DOCKER_AUTH}" ]]
then
  orchestrator_dir="${current_dir}/orchestrator"
  envsubst < "${orchestrator_dir}/templates/private-registry-secret.tpl" > "${orchestrator_dir}/private-registry-secret.yaml"
fi

kubectl apply -f orchestrator/
