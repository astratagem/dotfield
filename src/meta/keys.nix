# SPDX-FileCopyrightText: 2023-2026 Chris Montgomery <chmont@protonmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later
{ inputs, ... }:
let
  inherit (inputs.haumea.lib) load loaders matchers;
in
{
  meta.keys = load {
    src = ./data/keys;
    loader = [
      (matchers.nix loaders.default)
      (matchers.always (_: builtins.readFile))
    ];
  };
}
