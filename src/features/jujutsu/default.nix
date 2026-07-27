flake@{
  inputs,
  self,
  ...
}:
let
  inherit (inputs.apparat.lib) isEmpty;
in
{
  aspects.development.home =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      inherit (flake.config.meta.users.${config.home.username}) whoami;
    in
    {
      imports = [
        self.modules.homeManager.jujutsu-signing
      ];

      home.packages = [
        pkgs.jj-pre-push
      ];

      # This should be, for now, the developer's responsibility.  It is not
      # on individual projects to add an ignore for somebody's exotic
      # workflow until that workflow becomes widely adopted.
      programs.git.ignores = [ ".jj*" ];

      programs.jjui.enable = true;

      programs.jujutsu = {
        enable = true;
        settings = lib.mkMerge [
          {
            ui = {
              log-synthetic-elided-nodes = lib.mkDefault true;
              # For interoperability with other tools that don't know jujutsu.
              # conflict-marker-style = "git";
              # diff-formatter = ":git";
            };

            git = {
              private-commits = "blacklist()";
              write-change-id-header = true;
            };

            snapshot.auto-update-stale = true;
          }
          (lib.mkIf (!(isEmpty whoami.name) && !(isEmpty whoami.email.primary)) {
            user = {
              name = whoami.name or "";
              email = whoami.email.primary or "";
            };
          })
        ];
      };
    };
}
