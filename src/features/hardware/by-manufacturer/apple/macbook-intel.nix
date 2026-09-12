# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.hardware__apple__macbook-intel = {
    requires = [
      "laptop"
      "hardware__apple__macbook"
    ];

    nixos = {
      hardware.facetimehd.enable = true;
      services.mbpfan.enable = true;
    };
  };
}
