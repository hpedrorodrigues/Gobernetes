#!/usr/bin/env bash
set -euo pipefail

function fetch_plugin() {
  local plugin_url=$1
  local plugin_path="/godata/plugins/external/$(basename ${plugin_url})"

  echo -e "\nDownloading plugin \"${plugin_url}\" to \"${plugin_path}\""
  curl --location \
    --fail \
    --retry 3 \
    --silent \
    --create-dirs \
    --output "${plugin_path}" \
    "${plugin_url}"
}

function download_plugins() {
  local plugin_urls=(
    "https://github.com/gocd/docker-registry-artifact-plugin/releases/download/1.0.0/docker-registry-artifact-plugin-1.0.0-3.jar"
    "https://github.com/gocd-contrib/github-oauth-authorization-plugin/releases/download/2.1.0/github-oauth-authorization-plugin-2.1.0-15.jar"
    "https://github.com/gocd/kubernetes-elastic-agents/releases/download/v1.0.1/kubernetes-elastic-agent-1.0.1-107.jar"
    "https://github.com/indix/gocd-s3-artifacts/releases/download/v5.1.0/s3fetch-assembly-v5.1.0.jar"
    "https://github.com/indix/gocd-s3-artifacts/releases/download/v5.1.0/s3material-assembly-v5.1.0.jar"
    "https://github.com/indix/gocd-s3-artifacts/releases/download/v5.1.0/s3publish-assembly-v5.1.0.jar"
    "https://github.com/ashwanthkumar/gocd-build-github-pull-requests/releases/download/v1.3.5/github-pr-poller-1.3.5.jar"
    "https://github.com/gocd-contrib/gocd-build-status-notifier/releases/download/1.4/github-pr-status-1.4.jar"
    "https://github.com/gocd-contrib/script-executor-task/releases/download/0.3/script-executor-0.3.0.jar"
    "https://github.com/tomzo/gocd-yaml-config-plugin/releases/download/0.6.2/yaml-config-plugin-0.6.2.jar"
  )

  for plugin_url in "${plugin_urls[@]}"
  do
    fetch_plugin "${plugin_url}"
  done
}

function validate_plugins() {
  local checksum_file="/godata/plugins/external/plugins.MD5"
  echo -e "\nValidating plugins integrity: \"${checksum_file}\"\n"

  sed -i 's/\*/\*\/godata\/plugins\/external\//g' "${checksum_file}"
  md5sum -c "${checksum_file}"
}

download_plugins
validate_plugins
