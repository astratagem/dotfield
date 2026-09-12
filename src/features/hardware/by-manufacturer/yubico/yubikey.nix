# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.hardware__yubico__yubikey = {
    nixos =
      { lib, pkgs, ... }:
      {
        services.pcscd.enable = true;
        hardware.gpgSmartcards.enable = true;
        services.udev.packages = [ pkgs.yubikey-personalization ];
        environment.systemPackages = [
          pkgs.age-plugin-yubikey
          pkgs.yubikey-personalization
          pkgs.yubikey-manager
        ];
      };

    home = {
      services.gpg-agent.enableScDaemon = true;
    };
  };
}
