# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.development.home =
    { lib, config, ... }:
    lib.mkIf config.programs.starship.enable {
      programs.starship.settings =
        builtins.readFile ./config/dot-config/starship.toml |> builtins.fromTOML;
    };
}
