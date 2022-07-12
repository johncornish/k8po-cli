#!/usr/bin/env bash -e

K8PO_REPO_ROOT=~/workspace/k8po-cli

function reinstall() {
  pushd "${K8PO_REPO_ROOT}" > /dev/null
    ./install.sh
  popd > /dev/null
}

function check_install() {
  if [ ! -d "${K8PO_REPO_ROOT}" ]; then
    confirm "k8po-cli is not installed at '${K8PO_REPO_ROOT}'; would you like to install it?" || return 0

    mkdir -p ~/workspace/
    pushd ~/workspace/ > /dev/null
      git clone git@github.com:johncornish/k8po-cli.git
    popd > /dev/null

    reinstall
  fi
}

# thanks to https://www.christianengvall.se/check-for-changes-on-remote-origin-git-repository/
function check_update() {
  if [ ! -d "${K8PO_REPO_ROOT}" ]; then
    echo 'tried to update but there is no k8po-cli installation'
    return 0
  fi

  pushd "${K8PO_REPO_ROOT}" > /dev/null
    branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "${branch}" != "main" ]; then
      echo "WARNING: I noticed your installation of 'k8po-cli' is on branch '${branch}' instead of 'main'--you are using a custom version of 'k8po-cli'"
      echo "skipping auto-updates for branch '${branch}'"
      return 0
    fi

    git fetch
    headhash=$(git rev-parse HEAD)
    upstreamhash=$(git rev-parse main@{upstream})

    if [ "${headhash}" != "${upstreamhash}" ]; then
      confirm "k8po-cli is out of date; would you like to update?" || return 0

      git pull
      reinstall
    fi
  popd > /dev/null
}

function main() {
  check_install
  check_update
}

if ! command -v k8po &> /dev/null; then
    echo 'add the following to your shell profile:'
    echo 'export PATH="$PATH:$HOME/workspace/k8po-cli/bin"'
fi

main $@
