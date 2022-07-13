#!/bin/bash -e

K8PO_REPO_ROOT=$HOME/workspace/k8po-cli
source ${K8PO_REPO_ROOT}/hack/test/k8po-init.sh

function main() {
  # TODO: what if we run a check and automatically start Docker?
  # I run into this every freaking time.
  kind delete cluster
	kind create cluster
}

main $@
