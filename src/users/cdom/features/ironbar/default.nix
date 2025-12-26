{ inputs, ... }:
{
  users.cdom.aspects.desktop-sessions__wayland-wm.home =
    {
      ...
    }:
    {
      imports = [
        inputs.ironbar.homeManagerModules.default
        ./__check-weather.nix
      ];

      programs.ironbar = {
        enable = true;
        systemd = true;
      };
    };
}
