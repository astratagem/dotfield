# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

flake@{ ... }:
{
  hosts.nixos.ryosuke = {
    configuration =
      { config, ... }:
      let
        username = "cdom";
      in
      {
        users.users.${username} = {
          uid = 1000;
          isNormalUser = true;
          openssh.authorizedKeys.keys = flake.config.meta.users.cdom.keys.ssh;
          extraGroups = [ "wheel" ];
        };
      };

    users.cdom = {
      configuration = {
        programs.git.signing.signByDefault = true;
        home.stateVersion = "22.05";
      };
    };
  };
}
