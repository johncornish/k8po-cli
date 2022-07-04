function green() {
  echo -e $'\e[32m'$1$'\e[0m'
}

function red() {
  echo -e $'\e[31m'$1$'\e[0m'
}

function yellow() {
  echo -e $'\e[1;33m'$1$'\e[0m'
}

function print_msg_and_exit() {
  red "$1"
  exit 1
}

function pushd_check() {
  local d=$1
  pushd ${d} || print_msg_and_exit "Entering directory '${d}' with 'pushd' failed!"
}

function popd_check() {
  local d=$1
  popd || print_msg_and_exit "Leaving '${d}' with 'popd' failed!"
}

function wait_for_cluster_ready() {
  echo "Waiting for all Pods to be 'Ready'"
  while ! kubectl wait --for=condition=Ready pod --all -l exclude-me!=true --all-namespaces &> /dev/null; do
    echo "Waiting for all Pods to be 'Ready'"
    sleep 5
  done
  echo "All Pods are Ready"
}

function check_arg() {
  arg_name=$1
  arg_val=$2
  usage=$3
  if [ -z "${arg_val}" ]; then
    echo "missing argument '${arg_name}'; usage '${usage}'"
    exit 1
  fi
}
