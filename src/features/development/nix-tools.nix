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
  };
}
