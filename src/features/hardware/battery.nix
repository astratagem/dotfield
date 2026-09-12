# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.battery = {
    nixos =
      { pkgs, ... }:
      {
        services.upower.enable = true;
        networking.networkmanager.wifi.powersave = true;
      };

    home = {
      dconf.settings."org/gnome/desktop/interface".show-battery-percentage = true;
      services.poweralertd.enable = true;
    };
  };
}
