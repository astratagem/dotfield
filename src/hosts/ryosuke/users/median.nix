# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  hosts.nixos.ryosuke.configuration =
    let
      username = "median";
    in
    {
      users.users.${username} = {
        uid = 1001;
        isNormalUser = true;
        # TODO: generate
        # openssh.authorizedKeys.keys = flake.config.meta.users.${username}.keys.ssh;
      };
    };

  hosts.nixos.ryosuke.users.median = {
    configuration = {
      home.stateVersion = "24.05";
    };
  };
}
