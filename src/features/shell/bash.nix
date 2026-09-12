# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ self, ... }:
{
  aspects.core.nixos = {
    environment.pathsToLink = [ "/share/bash-completion" ];
  };

  aspects.core.home =
    { config, ... }:
    {
      imports = [
        self.modules.homeManager.bash-trampoline
      ];

      programs.bash = {
        enable = true;
        enableCompletion = true;
        sessionVariables = {
          "BASH_COMPLETION_USER_FILE" = "${config.xdg.dataHome}/bash/completion";
        };
      };
    };
}
