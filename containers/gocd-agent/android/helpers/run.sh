#!/usr/bin/env bash
set -eou pipefail

cur_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

source $cur_dir/common.sh

function _run() {
  docker run \
    --name "${image_name}" \
    -p8153:8153 \
    -p8154:8154 \
    -d "${image_name}:${image_version}"
}

_run
