# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ inputs, ... }:
{
  aspects.hardware__lenovo__thinkpad-x1-13th-gen = {
    requires = [
      "hardware__thunderbolt"
      "laptop"
    ];
    nixos = {
      imports = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen
      ];
    };
  };
}
