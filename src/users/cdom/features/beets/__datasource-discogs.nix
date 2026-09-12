# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  # https://beets.readthedocs.io/en/stable/plugins/discogs.html#configuration
  programs.beets.settings.discogs = {
    # "Techno" vs. only "Electronic"
    append_style_genre = true;
    separator = "; ";
    # Consider matches with same weight as the MusicBrainz source.  MB data
    # is generally less complete and more prone to mistakes.  There is
    # currently no way to disable MusicBrainz entirely.
    source_weight = 0.0;
    # Example:
    # <https://www.discogs.com/Handel-Sutherland-Kirkby-Kwella-Nelson-Watkinson-Bowman-Rolfe-Johnson-Elliott-Partridge-Thomas-The-A/release/2026070>
    # true => "Athalia, Act I, Scene I: Sinfonia"
    # false => "Sinfonia"
    index_tracks = true;
  };
}
