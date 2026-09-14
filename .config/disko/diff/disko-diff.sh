#!/usr/bin/env bash

# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Compare the filesystems a host's disko layout would produce against
# the filesystems its running configuration declares.

set -euo pipefail

host="${1:?usage: disko-diff.sh <host>}"
root="${PRJ_ROOT:-$(git rev-parse --show-toplevel)}"
here="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if ! nix eval --json "${root}#diskoConfigurations" --apply builtins.attrNames |
    jq -e --arg h "${host}" 'index($h)' >/dev/null; then
    >&2 echo "no disko layout for '${host}' (see src/hosts/${host}/disk-layout.nix)"
    exit 1
fi

declared="$(nix eval --impure --json "${root}#nixosConfigurations.${host}.config.fileSystems" \
    --apply "import ${here}/__pick-filesystems.nix")"

# `nix eval --file` would serialize the function itself rather than apply
# `--argstr` to it, so evaluate this one with nix-instantiate.
generated="$(nix-instantiate --eval --strict --json "${here}/__generated-filesystems.nix" \
    --argstr root "${root}" --argstr host "${host}")"

# Emits one line per finding, then a trailing VERDICT line consumed below.
report="$(jq -nr --argjson a "${declared}" --argjson b "${generated}" \
    --from-file "${here}/__diff-filesystems.jq")"

printf '%s\n' "${report%VERDICT *}"

if [[ ${report##*VERDICT } -gt 0 ]]; then
    echo "${host}: layout does NOT match the running config -- do not run disko against this host"
    exit 1
fi
echo "${host}: fsType and mount options match; review any NOTE lines above before formatting"
