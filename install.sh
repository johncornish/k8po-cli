#!/usr/bin/env bash -e

K8PO_REPO_ROOT=$(git rev-parse --show-toplevel)

if ! command -v k8po &> /dev/null; then
    echo 'add the following to your shell profile:'
    echo 'export PATH="$PATH:$HOME/workspace/k8po-cli/bin"'
fi
