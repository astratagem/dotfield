{
  aspects.graphical.nixos = { config, pkgs, ... }: {
    services.ddccontrol.enable = true;
    hardware.i2c.enable = true;
    environment.systemPackages = [
      pkgs.ddcutil
    ];

    users.groups.i2c = { inherit (config.users.groups.wheel) members; };
  };
}
