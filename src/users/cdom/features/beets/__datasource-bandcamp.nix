# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  programs.beets.settings.bandcamp = {
    art = true;
    # exclude_extra_fields = [ ];
    genre = {
      # always_include = [ ];
      capitalize = true;
      # maximum = 0;
      # <https://github.com/snejus/beetcamp/blob/main/README.md#genre-modes>
      mode = "progressive";
    };
    # search_max = 2;
  };

}
