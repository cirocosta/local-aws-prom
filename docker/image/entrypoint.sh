#!/bin/bash

set -o errexit
set -o pipefail
set -o xtrace

readonly PROMETHEUS_BASE_CONFIG_DIRECTORY="/etc/prometheus/config"
readonly PROMETHEUS_CONFIG_FILE="$PROMETHEUS_BASE_CONFIG_DIRECTORY/config.yml"

main() {
  local template_file="$PROMETHEUS_BASE_CONFIG_DIRECTORY/${ENVIRONMENT}.yml"
  local output_file="$PROMETHEUS_CONFIG_FILE"

  template_configuration_file "$template_file" "$output_file"
  run_prometheus "$@"
}

# Replaces environment variables defined in a
# template file ($1) and outputs the generated
# output in a different file ($2).
template_configuration_file() {
  local input=$1
  local output=$2

  echo "INFO:
  Templating configuration file.

  INPUT:  $input
  OUTPUT: $output
  "

  cat $input | envsubst -no-unset >$output
}

run_prometheus() {
  echo "INFO:
  Initiating prometheus.

  PROMETHEUS_CONFIG_FILE: $PROMETHEUS_CONFIG_FILE
  "

  exec prometheus \
    --config.file=$PROMETHEUS_CONFIG_FILE "$@"
}

main "$@"
