# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  users.cdom.aspects.development.home = {
    programs.git.settings.alias =
      let
        withDifft = s: "-c diff.external=difft ${s}";
      in
      {
        "dl" = withDifft "log -p --ext-diff";
        "ds" = withDifft "show --ext-diff";
        "dft" = withDifft "diff";
      };
  };
}
