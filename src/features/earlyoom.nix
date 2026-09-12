# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ lib, ... }: {
  aspects.core.nixos = {
    services.earlyoom.enable = true;
    # <https://discourse.nixos.org/t/nix-build-ate-my-ram/35752/5>
    services.earlyoom.extraArgs =
      let
        catPatterns = patterns: builtins.concatStringsSep "|" patterns;
        preferPatterns = [
          ".?firefox"
          "ipfs"
          "java" # If it's written in java it's uninmportant enough it's ok to kill it
        ];
        avoidPatterns = [
          "bash"
          "mosh-server"
          "sshd"
          "systemd"
          "systemd-logind"
          "systemd-udevd"
          "tmux: client"
          "tmux: server"
        ];
      in
      [
        "--prefer"
        "'^(${catPatterns preferPatterns})'"
        "--avoid"
        "'^(${catPatterns avoidPatterns})'"
      ];
  };

  aspects.graphical.nixos = {
    services.earlyoom.enableNotifications = lib.mkDefault true;
  };
}
