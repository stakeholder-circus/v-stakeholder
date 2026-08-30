#!/usr/bin/env bash
set -euo pipefail

version="${V_VERSION:-0.5.2}"
platform="${RUNNER_OS:?RUNNER_OS is required}"
architecture="${RUNNER_ARCH:?RUNNER_ARCH is required}"

case "${platform}/${architecture}" in
  Linux/X64)
    asset=v_linux.zip
    checksum=86caf9e70c3342d48ef19eb4f6c47b709f18c90ae86255520d5c29df6b482e23
    executable=v
    ;;
  Linux/ARM64)
    asset=v_linux_arm64.zip
    checksum=7e102f0ecc722bc59fea83ab1c99ae49c2f7be8f30abee9443220e452a439ed3
    executable=v
    ;;
  macOS/X64)
    asset=v_macos_x86_64.zip
    checksum=de19ef02874aec502f091b75e504e4836da38f627ddf7f7f9ecf6e8cf262f9d0
    executable=v
    ;;
  macOS/ARM64)
    asset=v_macos_arm64.zip
    checksum=e539a8dc3aeea47267f3cf00c25c4f0a364d8037fb13f5379d2a574a7abac8ee
    executable=v
    ;;
  Windows/X64)
    asset=v_windows.zip
    checksum=5f1d619b6b04a2b54b4ad21826a25bdcba2acf75a941c8f72fc95672b6b064ca
    executable=v.exe
    ;;
  *)
    printf 'Unsupported GitHub runner: %s/%s\n' "$platform" "$architecture" >&2
    exit 2
    ;;
esac

archive="${RUNNER_TEMP:?RUNNER_TEMP is required}/${asset}"
install_root="${RUNNER_TEMP}/v-${version}"
curl --fail --location --silent --show-error \
  "https://github.com/vlang/v/releases/download/${version}/${asset}" \
  --output "$archive"
printf '%s  %s\n' "$checksum" "$archive" | sha256sum --check --strict
rm -rf "$install_root"
mkdir -p "$install_root"
unzip -q "$archive" -d "$install_root"
test -x "${install_root}/v/${executable}"
printf '%s\n' "${install_root}/v" >> "${GITHUB_PATH:?GITHUB_PATH is required}"
"${install_root}/v/${executable}" version
