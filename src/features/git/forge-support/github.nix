flake@{ inputs, lib, ... }:
let
  inherit (inputs.apparat.lib) isEmpty;
in
{
  aspects.development.home =
    { config, pkgs, ... }:
    let
      inherit (flake.config.meta.users.${config.home.username}) whoami;
    in
    lib.mkMerge [
      {
        home.packages = [
          pkgs.gh
          pkgs.hub
        ];

        programs.gh.enable = true;
        programs.gh.settings.git_protocol = lib.mkDefault "ssh";
      }
      (lib.mkIf (!isEmpty (whoami.accounts.github or false)) {
        programs.git.settings.github.user = whoami.accounts.github;
      })
    ];
}
