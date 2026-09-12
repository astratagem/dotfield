# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, ... }:
let
  inherit (config.meta.users.cdom) whoami;
in
{
  users.cdom.aspects.core.home =
    { pkgs, ... }:
    {
      programs.ghostty.settings.command = "fish";

      programs.git.signing.key = whoami.pgp.id;
      services.gpg-agent = {
        enableSshSupport = true;
        enableExtraSocket = true;
      };
    };
}
