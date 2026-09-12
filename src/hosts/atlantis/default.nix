# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, ... }:
let
  inherit (config.meta) keys;
in
{
  meta.hosts.atlantis = {
    host = "atlantis.whatbox.ca";
    users.syadasti.keys = {
      age = keys.age.syadasti-at-atlantis;
      ssh = [ keys.ssh.syadasti-at-atlantis ];
    };
  };
}
