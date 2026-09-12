# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.workstation.nixos = {
    programs.nh = {
      enable = true;
      flake = "/etc/nixos";

      # Manage store cleanup for workstations.  Unlike `nix.gc` this
      # also prunes per-user home-manager generations.
      clean.enable = true;
      clean.extraArgs = "--keep 5 --keep-since 14d";
    };
  };
}
