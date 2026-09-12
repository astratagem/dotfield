# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.login__regreet.nixos = {
    services.greetd.enable = true;

    users.extraUsers.greeter = {
      home = "/tmp/greeter-home";
      createHome = true;
    };

    programs.regreet = {
      enable = true;
      cageArgs = [
        "-s"
        "-m"
        "last"
      ];
      settings = {
        appearance = {
          greeting_msg = "Hello Word!";
        };
        commands = {
          reboot = [
            "systemctl"
            "reboot"
          ];
          poweroff = [
            "systemctl"
            "poweroff"
          ];
        };
        widget.clock = {
          format = "%a %T";
          label_width = 150;
        };
      };
    };
  };
}
