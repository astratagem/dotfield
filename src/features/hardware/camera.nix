# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.workstation.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.v4l-utils
      ];
    };
}
