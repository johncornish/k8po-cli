#!/usr/bin/env bash -e

K8PO_REPO_ROOT=~/workspace/k8po-cli
source ${K8PO_REPO_ROOT}/hack/test/k8po-init.sh
USAGE='k8po COMMAND_NAME USAGE_ARGS'

function main() {
  VARS

  USAGE_CHECKS

  echo "main called with args '$@'"
}

main $@
