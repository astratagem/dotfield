# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gnupg
        gpgme
        (writeShellScriptBin "gpg-agent-restart" ''
          pkill gpg-agent ; pkill ssh-agent ; pkill pinentry ; eval $(gpg-agent --daemon --enable-ssh-support)
        '')
      ];

      programs.gpg = {
        enable = true;
        settings = {
          keyserver = "hkps://keyserver.ubuntu.com";
          # keyserver = "hkps://pgpkeys.eu"; # only server providing sync
          # keyserver = "hkps://keys.openpgp.org";
          # keyserver = "hkps://keys.mailvelope.com";
        };
      };
    };
}
