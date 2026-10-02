# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  aspects.core.nixos =
    { pkgs, ... }:
    {
      home-manager = {
        # Prevent activation failures by specifying how to handle file
        # collisions.  Just back them up, don't freak out.
        backupFileExtension = "bak";
        overwriteBackup = true;

        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };

}
