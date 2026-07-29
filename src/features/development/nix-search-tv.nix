{
  aspects.development.home =
    { config, lib, ... }:
    let
      cfg = config.programs.nix-search-tv;
    in
    {
      programs.nix-search-tv.enable = true;

      # The existing home-manager module provides no mechanism for changing
      # the name of the television channel.  I prefer the shorter "nix" over
      # "nix-search-tv".
      programs.nix-search-tv.enableTelevisionIntegration = false;
      programs.television.channels.nix = (
        let
          path = lib.getExe cfg.package;
        in
        {
          metadata = {
            name = "nix";
            description = "Search nix options and packages";
          };

          source.command = "${path} print";
          preview.command = ''${path} preview "{}"'';

          actions.run = {
            command = ''nix run {replace:s/\/ /#/g}'';
            mode = "fork";
          };
          actions.shell = {
            command = ''nix shell {replace:s/\/ /#/g}'';
            mode = "execute";
          };
        }
      );
    };
}
