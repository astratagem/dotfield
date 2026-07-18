{
  aspects.development.home = { pkgs, ... }: {
    home.packages = [
      pkgs.nix-init
      pkgs.nix-inspect
      pkgs.nix-search-tv
      pkgs.nix-update
      pkgs.nixfmt
      pkgs.nixpkgs-review
    ];

    programs.television.channels = {
      nix-search = {
        metadata = {
          name = "nix-search";
          requirements = [ "nix-search-tv" ];
        };
        preview = {
          command = "nix-search-tv preview {}";
        };
        source = {
          command = "nix-search-tv print";
        };
      };
    };
  };
}
