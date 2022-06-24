#!/usr/bin/env bash -e

K8PO_CONFIG_ROOT=~/.k8po
source ${K8PO_CONFIG_ROOT}/hack/test/k8po-init.sh

function main() {
  echo "main called with args '$@'"
}

main $@
