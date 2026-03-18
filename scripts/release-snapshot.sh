#!/usr/bin/env bash

set -euo pipefail

target="${1:-$(go env GOOS)-$(go env GOARCH)}"

case "$target" in
  linux-amd64)
    config=".goreleaser.linux.yaml"
    ;;
  darwin-amd64)
    config=".goreleaser.darwin-amd64.yaml"
    ;;
  darwin-arm64)
    config=".goreleaser.darwin-arm64.yaml"
    ;;
  windows-amd64)
    config=".goreleaser.windows.yaml"
    ;;
  *)
    echo "unsupported release target: $target" >&2
    echo "supported targets: linux-amd64, darwin-amd64, darwin-arm64, windows-amd64" >&2
    exit 1
    ;;
esac

exec goreleaser release --clean --snapshot --skip=publish --config "$config"
