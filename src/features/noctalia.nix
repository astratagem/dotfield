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

    home = { config, lib, ... }: {
      programs.noctalia.enable = true;
      programs.noctalia.systemd.enable = true;
      programs.noctalia.settings = {
        shell.launch_apps_as_systemd_services = true;
        shell.screenshot = lib.mkDefault "${config.home.homeDirectory}/Pictures/Screenshots";
      };
    };
  };

  aspects.desktop-sessions__niri.home = { lib, ... }: {
    programs.noctalia.settings = {
      widget.workspaces.label_source = lib.mkDefault "name";
    };
  };
}
