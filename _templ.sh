#!/usr/bin/env bash -e

K8PO_REPO_ROOT=~/workspace/k8po-cli
source ${K8PO_REPO_ROOT}/hack/test/k8po-init.sh

function main() {
  echo "main called with args '$@'"
}

main $@
