#!/bin/bash
# run shell tests with unix domain sockets

set -e
export MGMT_SERVER_URLS=unix://server.sock:0
export MGMT_CLIENT_URLS=unix://client.sock:0

. "$(dirname "$0")/test-shell.sh"
