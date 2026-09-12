# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, ... }:
let
  inherit (config) meta;
in
{
  users.seadoom = {
    aspects.core.home = {
      sops.defaultSopsFile = ../cdom/secrets/secrets.yaml;
    };
  };
  meta.users.seadoom = meta.users.cdom;
}
