# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, ... }:
let
  inherit (config.meta) keys;
in
{
  meta.hosts.brakhage = {
    users.blink.keys.ssh = [ keys.ssh.blink-at-brakhage ];
    syncthing.id = "DIRTDK2-3ODIIYJ-SB3E2A6-PCQP3RZ-M7KDQGU-7TMZ525-YGVXW5C-HHDS6A3";
  };
}
