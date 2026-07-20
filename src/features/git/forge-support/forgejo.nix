{
  aspects.development.home = { pkgs, ... }: {
    home.packages = [ pkgs.forgejo-cli ];
  };
}
