# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ inputs, ... }:
{
  aspects.development__kleinweb = {
    requires = [
      "development"
      "development__php"
    ];

    nixos = {
      imports = [
        inputs.beams.modules.nixos.default
      ];
    };

    home =
      { config, ... }:
      {
        imports = [
          inputs.beams.modules.homeManager.default
        ];
      };
  };
}
