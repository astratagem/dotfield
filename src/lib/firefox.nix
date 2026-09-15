# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

let
  inherit (builtins) map;

  withPrefix = s: "@" + s;
  withAlias = alias: attrs: attrs // { definedAliases = (map withPrefix [ alias ]); };
  withAliases = aliases: attrs: attrs // { definedAliases = (map withPrefix aliases); };

  engine = template: { urls = [ { inherit template; } ]; };
in
{
  flake.lib.firefox = {
    inherit engine;

    engine' = alias: template: withAlias alias (engine template);

    engineWithAliases = aliases: template: withAliases aliases (engine template);
  };
}
