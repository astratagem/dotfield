{
  users.cdom.aspects.core.home =
    { pkgs, ... }:
    let
      shellAliases = import ./__aliases.nix { inherit pkgs; };
      shellAbbrs = import ./__abbrs.nix { inherit pkgs; };
    in
    {
      # FIXME: results in syntax errors
      # FIXME: `home.shellAliases` and `home.sessionVariables` are not propagated
      #        into the nushell session.  we get by without `home.sessionVariables`
      #        thanks to the trampoline.
      # programs.nushell.shellAliases = shellAbbrs // shellAliases;

      programs.nushell.settings = {
        use_ansi_coloring = true;
        history = {
          max_size = 1000000;
          file_format = "sqlite";
          isolation = true;
        };
      };
    };
}
