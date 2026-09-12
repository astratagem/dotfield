# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  programs.beets.settings.lastgenre = {
    auto = true;
    canonical = true;
    count = 3;
    force = true;
    separator = "; ";
    source = "album";
    # NOTE: This does not play well with acronyms e.g. "IDM" becomes "Idm".
    title_case = true;
    whitelist = true;
  };
}
