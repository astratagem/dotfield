flake@{ inputs, lib, ... }:
let
  inherit (inputs.apparat.lib) isEmpty;
in
{
  aspects.core = {
    nixos = {
      programs.git.enable = true;
      programs.git.config = {
        safe.directory = [ "/etc/nixos" ];
      };
    };
  };

  aspects.development.home =
    { config, pkgs, ... }:
    let
      inherit (flake.config.meta.users.${config.home.username}) whoami;
    in
    lib.mkMerge [
      {
        programs.git = {
          enable = true;
          package = pkgs.gitFull;
          settings = {
            alias = {
              snapshot = ''!git stash save "snapshot: $(date)" && git stash apply "stash@{0}"'';
            };

            init.defaultBranch = lib.mkDefault "main";
            push.default = "current";
            fetch.recurseSubmodules = true;

            # Result: <short-sha> <commit-message> (<pointer-names>) -- <commit-author-name>; <relative-time>
            pretty.nice = lib.mkDefault "%C(yellow)%h%C(reset) %C(white)%s%C(cyan)%d%C(reset) -- %an; %ar";

            merge.conflictstyle = "diff3";
            rerere.enabled = true;
            difftool.prompt = false;
            pager.difftool = true;
          };
        };
      }
      (lib.mkIf (!isEmpty (whoami.name or false)) {
        programs.git.settings.user.name = whoami.name;
      })
      (lib.mkIf (!isEmpty (whoami.email.primary or false)) {
        programs.git.settings.user.email = whoami.email.primary;
      })
    ];
}
