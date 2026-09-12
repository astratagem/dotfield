# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  writeShellApplication,
  cliphist,
  fzf,
  wl-clipboard,
}:

(writeShellApplication {
  name = "clipsel";
  runtimeInputs = [
    cliphist
    fzf
    wl-clipboard
  ];
  text = ''
    cliphist list | fzf | cliphist decode | wl-copy
  '';
  meta.website = "https://github.com/sentriz/cliphist#picker-examples";
})
