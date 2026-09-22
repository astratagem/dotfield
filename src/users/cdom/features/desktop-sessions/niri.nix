{
  users.cdom.aspects.desktop-sessions__niri = {
    home = {
      services.swayidle.timeouts = [
        {
          timeout = 20 * 60;
          command = "niri msg output * off";
          resumeCommand = "niri msg output * on";
        }
      ];
    };
  };
}
