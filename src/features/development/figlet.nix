# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.development.home = { pkgs, ... }: {
    home.packages = [ pkgs.figlet ];

    programs.television.channels.figlet-fonts = {
      metadata = {
        description = "Browse and preview figlet fonts";
        name = "figlet-fonts";
        requirements = [ "figlet" ];
      };
      preview = {
        command = "figlet -f '{}' 'The quick brown fox jumps over the lazy dog.'";
      };
      source = {
        command = "for i in \"$(figlet -I2)\"/*.flf; do basename \"$i\" .flf; done | sort";
      };
    };
  };
}
