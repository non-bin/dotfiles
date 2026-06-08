#!/usr/bin/env bash
parent_path=$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd -P
)

cd "$parent_path"
./reload.sh -c -r -p || read
