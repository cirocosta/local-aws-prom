#!/bin/bash

set -o errexit

readonly PROMETHEUS_CONFIG_FILE="/etc/prometheus/config/config.yml"
readonly VAGRANT_CONFIG_FILE="/etc/prometheus/config/vagrant.yml"

main() {
  template_configurations "$VAGRANT_CONFIG_FILE"
  run_prometheus "$@"
}

template_configurations() {
  local file=$1

  cat $file | envsubst -no-unset >$PROMETHEUS_CONFIG_FILE
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
