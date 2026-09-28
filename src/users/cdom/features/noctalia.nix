{
  users.cdom.aspects.noctalia.home = {
    programs.noctalia.settings = {
      shell.window_switcher.mru = true; # sort by most-recent

      widget.battery.show_label = false;
      widget.clock.format = "{:%H:%M:%S}";
      widget.network.show_label = false;
      widget.volume.show_label = false;
    };
  };

  users.cdom.aspects.desktop-sessions__niri.home = {
    programs.noctalia.settings = {
      backdrop = {
        enabled = true;
        blur_intensity = 0.5;
        tint_intensity = 0.3;
      };
    };
  };
}
