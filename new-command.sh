#!/usr/bin/env bash -e

K8PO_REPO_ROOT=$(git rev-parse --show-toplevel)

command_name=$1
cp "${K8PO_REPO_ROOT}/hack/_templ.sh" "${K8PO_REPO_ROOT}/.k8po/hack/test/${command_name}.sh"
