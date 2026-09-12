# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  programs.beets.settings = {
    asciify_paths = true;
    ignore_hidden = true;
    max_filename_length = 255;

    paths = {
      default = "%the{%first{$albumartist}}/$album%aunique{}/%if{$multidisc,$disc-}$track - $title";
    };

    badfiles = {
      check_on_import = true;
    };

    filetote = {
      extensions = [
        ".cue"
        ".nfo"
        ".pdf"
      ];
      filenames = "cover.jpg cover.png";
      pairing = {
        enabled = true;
        pairing_only = true;
        extensions = [ ".lrc" ];
      };
    };
  };
}
