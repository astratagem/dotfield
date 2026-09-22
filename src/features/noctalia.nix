{
  aspects.noctalia = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.noctalia
      ];
    };

    home = {
      programs.noctalia.enable = true;
      programs.noctalia.systemd.enable = true;
    };
  };
}
