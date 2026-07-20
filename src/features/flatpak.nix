{ inputs, ... }:
{
  aspects.graphical.nixos = {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

    services.flatpak.enable = true;
  };

  aspects.graphical.home = {
    imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

    programs.television.channels.flatpak = {
      actions = {
        run = {
          command = "flatpak run '{split:\t:0}'";
          description = "Launch the selected application";
          mode = "execute";
        };
        uninstall = {
          command = "flatpak uninstall '{split:\t:0}'";
          description = "Uninstall the selected application";
          mode = "execute";
        };
        update = {
          command = "flatpak update '{split:\t:0}'";
          description = "Update the selected application";
          mode = "execute";
        };
      };
      metadata = {
        description = "List and manage Flatpak applications";
        name = "flatpak";
        requirements = [ "flatpak" ];
      };
      preview = {
        command = "flatpak info '{split:\t:0}' 2>/dev/null";
      };
      source = {
        command = "flatpak list --app --columns=application,name,version 2>/dev/null";
        display = "{split:\t:1} ({split:\t:2})";
        output = "{split:\t:0}";
      };
    };
  };
}
