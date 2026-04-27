{ withSystem }:
{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkOption;
  cfg = config.programs.fzf-tab-completion;
in
{
  options.programs.fzf-tab-completion = {
    enable = mkEnableOption "fzf-tab-completion";

    package = mkOption {
      default = withSystem pkgs.stdenv.hostPlatform.system (
        { config, ... }: config.packages.fzf-tab-completion
      );
      defaultText = lib.literalMD "`packages.fzf-tab-completion` from the dotfield flake";
    };

    enableBashIntegration = lib.hm.shell.mkBashIntegrationOption { inherit config; };

    enableZshIntegration = lib.hm.shell.mkZshIntegrationOption { inherit config; };
  };

  config = lib.mkIf (cfg.enable) {
    programs.bash.initExtra = lib.mkIf cfg.enableBashIntegration ''
      source ${cfg.package}/share/bash/fzf-bash-completion.sh
      bind -x '"\t": fzf_bash_completion'
    '';

    programs.zsh.initContent = lib.mkIf cfg.enableZshIntegration ''
      source ${cfg.package}/share/zsh/fzf-zsh-completion.sh
      bindkey '^I' fzf_completion
    '';
  };
}
