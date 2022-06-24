#!/usr/bin/env bash -e

K8PO_REPO_ROOT=$(git rev-parse --show-toplevel)
rm -rf ~/.k8po
cp -r "${K8PO_REPO_ROOT}/.k8po" ~/.k8po

if ! command -v k8po &> /dev/null; then
    echo 'add the following to your shell profile:'
    echo 'export PATH="$PATH:$HOME/.k8po/bin"'
fi
