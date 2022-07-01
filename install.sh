#!/usr/bin/env bash -e

K8PO_REPO_ROOT=~/workspace/k8po-cli

function reinstall() {
  pushd "${K8PO_REPO_ROOT}" > /dev/null
    ./install.sh
  popd > /dev/null
}

function check_install() {
  if [ ! -d "${K8PO_REPO_ROOT}" ]; then
    read -p "k8po-cli is not installed at '${K8PO_REPO_ROOT}'; would you like to install it? [y/n]: " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      mkdir -p ~/workspace/
      pushd ~/workspace/ > /dev/null
        git clone git@github.com:johncornish/k8po-cli.git
      popd > /dev/null

      reinstall
    fi
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
      echo "tried to check k8po-cli repo for updates but branch was '${branch}'."
      return 0
    fi

    git fetch
    headhash=$(git rev-parse HEAD)
    upstreamhash=$(git rev-parse main@{upstream})

    if [ "${headhash}" != "${upstreamhash}" ]; then
      read -p "k8po-cli is out of date; would you like to update? [y/n]: " -n 1 -r
      echo
      if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
        git pull
        reinstall
      fi
    fi
  popd > /dev/null
}

function main() {
  if [ "${RUN_CHECKS}" == "" ]; then
    # TODO: usage options: ci, both, install, update
    RUN_CHECKS="both"
  fi

  if [ "${RUN_CHECKS}" == "ci" ]; then
    echo "RUN_CHECKS set to '${RUN_CHECKS}'; skipping checks"
  else
    [[ "${RUN_CHECKS}" == "both" || "${RUN_CHECKS}" == "install" ]] && check_install
    [[ "${RUN_CHECKS}" == "both" || "${RUN_CHECKS}" == "update" ]] && check_update
  fi
}

if ! command -v k8po &> /dev/null; then
    echo 'add the following to your shell profile:'
    echo 'export PATH="$PATH:$HOME/workspace/k8po-cli/bin"'
fi

main $@
