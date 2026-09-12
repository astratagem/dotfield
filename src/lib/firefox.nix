# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

let
  engine = template: { urls = [ { inherit template; } ]; };
  withAlias = s: attrs: attrs // { definedAliases = [ s ]; };
in
{
  flake.lib.firefox = {
    inherit engine;

    engine' = alias: template: withAlias "@${alias}" (engine template);
  };
}
