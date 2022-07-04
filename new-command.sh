#!/usr/bin/env bash -e

K8PO_REPO_ROOT=$(git rev-parse --show-toplevel)

command_name=$1
command_args=${@:2}
new_command_file="${K8PO_REPO_ROOT}/hack/test/${command_name}.sh"
cp "${K8PO_REPO_ROOT}/_templ.sh" $new_command_file

sed -i '' "s/COMMAND_NAME/${command_name}/g" $new_command_file

usage_args_str="<$(echo $command_args | sed 's/ /> </g')>"
sed -i '' "s/USAGE_ARGS/${usage_args_str}/g" $new_command_file

arg_count=1
vars_str=""
for arg in $command_args; do
  vars_str+="${arg}"'=$'"${arg_count}; "
  arg_count=$((arg_count + 1))
done
sed -i '' "s/VARS/${vars_str}/g" $new_command_file

usage_checks_str=""
for arg in $command_args; do
  usage_checks_str+="check_arg ${arg} "'$'"${arg}"' $USAGE; '
done
sed -i '' "s/USAGE_CHECKS/${usage_checks_str}/g" $new_command_file
