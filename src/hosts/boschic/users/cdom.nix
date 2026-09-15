# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

flake@{ self, ... }:
{
  hosts.nixos.boschic = {
    configuration =
      {
        pkgs,
        config,
        ...
      }:
      let
        username = "cdom";
      in
      {
        sops.secrets."users/${username}/hashed-password".neededForUsers = true;

        users.users.${username} = {
          uid = 1000;
          isNormalUser = true;
          hashedPasswordFile = config.sops.secrets."users/${username}/hashed-password".path;
          openssh.authorizedKeys.keys = flake.config.meta.users.cdom.keys.ssh;
          extraGroups = [ "wheel" ];
        };
      };

    users.cdom = {
      configuration = {
        programs.git.signing.signByDefault = true;
        programs.jujutsu.signing.gpg.enable = true;
        programs.jujutsu.signing.onPush = true;

        programs.rclone.remotes."whatbox".mounts."".enable = true;

        home.stateVersion = "25.05";
      };
    };
  };
}
