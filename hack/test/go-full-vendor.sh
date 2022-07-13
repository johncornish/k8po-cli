#!/usr/bin/env bash -e

K8PO_REPO_ROOT=$HOME/workspace/k8po-cli
source ${K8PO_REPO_ROOT}/hack/test/k8po-init.sh

function main() {
  go mod tidy
  go mod vendor
}

main $@
