# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  aspects.graphical.nixos = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.gpu-screen-recorder
      pkgs.gpu-screen-recorder-gtk
    ];
  };

  aspects.graphical.home =
    { pkgs, ... }:
    {
      services.flameshot.enable = true;

      home.packages = [
        pkgs.kooha
      ];
    };
}
