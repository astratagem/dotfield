# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.hardware__focusrite__scarlett-18i20-mk1 = {
    requires = [ "audio-pro" ];
    nixos = {
      # TODO:
      # musnix.soundcardPciId = "";
    };
  };
}
