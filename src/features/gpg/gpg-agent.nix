# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  aspects.workstation.home = { pkgs, ... }: {
    services.gpg-agent.enable = true;
    services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;

    # Enable smartcard
    programs.gpg.settings.use-agent = true;

    home.packages = [
      pkgs.gcr_3 # for pkgs.pinentry-gnome3 support

      (pkgs.writeShellScriptBin "gpg-agent-restart" ''
        pkill gpg-agent ; pkill ssh-agent ; pkill pinentry ; eval $(gpg-agent --daemon --enable-ssh-support)
      '')
    ];
  };
}
