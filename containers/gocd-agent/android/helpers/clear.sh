#!/usr/bin/env bash
set -eou pipefail

cur_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

source $cur_dir/common.sh

function _clear() {
  echo -e "\nDo you really want to delete all docker images and containers related to \"${image_name}\"? [y/n]"
  read choice

  if [[ "${choice}" == "y" ]]
  then
    docker images "${image_name}" -q --no-trunc | xargs docker rmi -f
    docker ps -a --filter "ancestor=${image_name}" -q --no-trunc | xargs docker rm
    docker ps -a --filter "name=${image_name}" -q --no-trunc | xargs docker rm
  fi
}

_clear
