{ self, ... }:
{
  aspects.core = {
    nixos =
      { pkgs, ... }:
      {
        environment.shells = [
          pkgs.bashInteractive
          pkgs.fish
          pkgs.nushell
        ];
      };

    home =
      { pkgs, ... }:
      {
        imports = [
          self.modules.homeManager.fzf-tab-completion
        ];

        programs.bat.enable = true;
        programs.bottom.enable = true;
        programs.carapace.enable = true;
        programs.dircolors.enable = true;
        programs.eza.enable = true;
        programs.fzf.enable = true;
        programs.info.enable = true;
        programs.less.enable = true;
        programs.zellij.enable = true;

        home.packages = [
          pkgs.bashInteractive
          pkgs.duf # <- du/df alternative
          pkgs.fx
          pkgs.glow
          pkgs.hexyl
          pkgs.igrep
          pkgs.ouch
        ];
      };
  };
}
