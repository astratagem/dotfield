{ inputs, moduleWithSystem, ... }:
{
  aspects.development.home = moduleWithSystem (
    perSystem@{ inputs' }:
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.ceamx.modules.homeManager.ceamx
      ];

      config = lib.mkIf config.programs.emacs.ceamx.enable {
        programs.emacs = {
          enable = true;
          package =
            if pkgs.stdenv.hostPlatform.isDarwin then
              pkgs.emacs30-macport
            else
              perSystem.inputs'.emacs-overlay.packages.emacs-unstable-pgtk;
        };

        stylix.targets.emacs.enable = false;
      };
    }
  );
}
