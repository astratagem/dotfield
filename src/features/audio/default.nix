{
  aspects.workstation.nixos =
    { config, pkgs, ... }:
    {
      security.rtkit.enable = true;

      environment.systemPackages = [
        pkgs.alsa-utils
        pkgs.easyeffects
        pkgs.pavucontrol
      ];

      services.pulseaudio.enable = false;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };

      users.groups.audio = { inherit (config.users.groups.wheel) members; };
    };
}
