# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.core = {
    nixos = {
      # XXX: yeah it's broken lazy-options.json non-deterministic fail
      # (can't revert to earlier flake.lock!!!)
      documentation.nixos.enable = false;
    };
  };
}
