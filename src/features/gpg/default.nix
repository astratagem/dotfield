# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gnupg
        gpgme
      ];

      programs.gpg = {
        enable = true;
        settings = {
          keyserver = "hkps://keyserver.ubuntu.com";
          # keyserver = "hkps://pgpkeys.eu"; # only server providing sync
          # keyserver = "hkps://keys.openpgp.org";
          # keyserver = "hkps://keys.mailvelope.com";

          charset = "utf-8";
          no-greeting = true;
          with-key-origin = true;

          # Enforce memory locking to avoid accidentally swapping GPG memory to disk
          require-secmem = true;

          # Output ASCII instead of binary
          armor = true;
        };
        scdaemonSettings.disable-ccid = true;
      };
    };
}
