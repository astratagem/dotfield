# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  flake.lib.fish = {
    toPluginAttrs = pkg: {
      inherit (pkg) src;
      name = pkg.pname;
    };
  };
}
