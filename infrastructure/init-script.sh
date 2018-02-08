#!/bin/bash

set -o errexit

readonly URL=https://github.com/prometheus/node_exporter/releases/download/v0.15.2/node_exporter-0.15.2.linux-amd64.tar.gz

main() {
  download_node_exporter
  run_node_exporter
}

download_node_exporter() {
  curl \
    -o /tmp/node_exporter.tgz \
    -SL \
    $URL

  tar \
    xzf /tmp/node_exporter.tgz \
    -C /tmp/ \
    --strip-components=1
}

run_node_exporter() {
  nohup /tmp/node_exporter 0<&- &>/dev/null &
}

main "$@"
