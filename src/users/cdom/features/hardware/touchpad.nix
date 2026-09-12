# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  users.cdom.aspects.touchpad.home = {
    dconf.settings."org/gnome/desktop/peripherals/touchpad" = {
      # Weirdly enough, some people prefer natural scroll.
      natural-scroll = false;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    wayland.windowManager.sway.config.input."type:touchpad" = {
      tap = "enabled";
      natural_scroll = "disabled";
    };
  };
}
