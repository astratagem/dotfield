# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  users.cdom.aspects.development__kleinweb.home =
    { config, ... }:
    {
      programs.git.includes = [
        {
          path = "${config.xdg.configHome}/git/tu-gitlab-credentials";
        }
        {
          # TIP: verify with e.g.:
          # $ fd -t d '\.git$' -H -x bash -c 'cd {//} && git config --get user.email'
          contents = {
            # FIXME: add this to an identity config -- flake whoami module
            # should support multiple identities
            user.email = "chrismont@temple.edu";
          };
          condition = "gitdir:~/Projects/work/";
          contentSuffix = "work-by-gitdir-gitconfig";
        }
      ];
    };
}
