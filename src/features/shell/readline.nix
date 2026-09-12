# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.core.home = {
    programs.readline.enable = true;
    programs.readline.variables = {
      # Expand tilde to home directory.
      expand-tilde = true;
    };
  };
}
