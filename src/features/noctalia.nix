{
  aspects.noctalia = {
    nixos =
      { pkgs, ... }:
      let
        pluginDeps = [
          pkgs.gpu-screen-recorder
          pkgs.gpu-screen-recorder-gtk
        ];
      in
      {
        environment.systemPackages = pluginDeps ++ [
          pkgs.noctalia
        ];
      };

    home = {
      programs.noctalia.enable = true;
      programs.noctalia.systemd.enable = true;
    };
  };
}
