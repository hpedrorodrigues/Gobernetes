#!/usr/bin/env bash
set -eou pipefail

cur_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

source $cur_dir/common.sh

function _build() {
  docker build \
    -t "${image_name}:${image_version}" \
    "${cur_dir}/.."
}

_build
