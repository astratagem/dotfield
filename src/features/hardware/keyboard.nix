# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ self, ... }:
{
  aspects.workstation = {
    nixos =
      { config, pkgs, ... }:
      {
        imports = [
          self.modules.nixos."hardware/keyboard/keyboardio"
        ];

        # Required to support flashing firmware.
        users.groups.plugdev = { inherit (config.users.groups.wheel) members; };

        # Required to use virtual input tools e.g. kanata, espanso.
        hardware.uinput.enable = true;
        users.groups.uinput = { inherit (config.users.groups.wheel) members; };

        hardware.keyboard.keyboardio.enable = true;
        hardware.keyboard.qmk.enable = true;
        hardware.keyboard.zsa.enable = true;

        environment.systemPackages = [
          pkgs.wally-cli
        ];
      };
  };

  aspects.graphical = {
    home =
      { lib, ... }:
      {
        home.keyboard.options = [ "compose:ralt" ];
        dconf.settings."org/gnome/desktop/input-sources" = {
          sources = [
            (lib.hm.gvariant.mkTuple [
              "xkb"
              "us"
            ])
          ];
          xkb-options = [
            "terminate:ctrl_alt_bksp"
            "compose:ralt"
          ];
        };

      };
  };

}
