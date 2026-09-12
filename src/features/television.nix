# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.core.home = {
    programs.television.enable = true;
    programs.television.channels = {
      recent-files = {
        metadata = {
          description = "Recently modified files";
          name = "recent-files";
          requirements = [
            "bat"
            "fd"
          ];
        };
        preview = {
          command = "bat -n --color=always '{}'";
        };
        source = {
          command = "fd -t f --changed-within 7d";
        };
      };
    };
  };
}
