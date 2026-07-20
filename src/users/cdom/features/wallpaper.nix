{ moduleWithSystem, ... }:
{
  users.cdom.aspects.desktop-sessions__wayland-wm.home = moduleWithSystem (
    perSystem@{ config }:
    {
      services.awww.enable = true;
      home.packages = [
        perSystem.config.packages.awww-randomize
      ];
    }
  );
}
