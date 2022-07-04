#!/usr/bin/env bash -e

K8PO_REPO_ROOT=~/workspace/k8po-cli
source ${K8PO_REPO_ROOT}/hack/test/k8po-init.sh
USAGE='k8po go-get-tool <tool_path> <tool_mod_link>'

function main() {
  tool_path=$1; tool_mod_link=$2; 

  check_arg "${USAGE}" tool_path $tool_path; check_arg "${USAGE}" tool_mod_link $tool_mod_link; 

  repo_root=$(git rev-parse --show-toplevel)
  tool_dir="${repo_root}/bin"
  if [ ! -d "${tool_dir}" ]; then
    echo "no bin folder found at ${tool_dir}; creating"
    mkdir -p "${tool_dir}"
  fi

  if [ -f "${tool_path}" ]; then
    echo "tool already found at path '${tool_path}'; exiting"
    exit 0
  fi

  GOBIN="${tool_dir}" go install "${tool_mod_link}"
}

main $@
