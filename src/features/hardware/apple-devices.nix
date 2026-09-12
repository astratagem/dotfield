# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.workstation.nixos =
    { pkgs, ... }:
    {
      services.usbmuxd.enable = true;
      services.usbmuxd.package = pkgs.usbmuxd;

      environment.systemPackages = [
        pkgs.libimobiledevice
        pkgs.ifuse
      ];
    };
}
