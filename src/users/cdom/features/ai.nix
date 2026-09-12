# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ moduleWithSystem, ... }:
{
  users.cdom.aspects.workstation.home = moduleWithSystem (
    perSystem@{ pkgs, inputs' }:
    {
      home.packages = [
        pkgs.aider-chat-full
        pkgs.mods # https://github.com/charmbracelet/mods
      ];
    }
  );
}
