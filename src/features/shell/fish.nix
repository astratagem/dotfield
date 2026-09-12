# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.core = {
    nixos = {
      programs.fish.enable = true;
    };

    home =
      { pkgs, ... }:
      {
        programs.fish.enable = true;
        programs.fzf.enableFishIntegration = true;
        programs.neovim.plugins = [ pkgs.vimPlugins.vim-fish ];
        home.extraOutputsToInstall = [ "/share/fish" ];
      };
  };

  aspects.development.home =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.fish-lsp ];
    };
}
