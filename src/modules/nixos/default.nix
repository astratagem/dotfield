# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  flake.modules.nixos = {
    "hardware/keyboard/keyboardio" = ./hardware/keyboard/keyboardio/__module.nix;
  };
}
