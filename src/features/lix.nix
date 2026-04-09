{
  aspects.core.nixos =
    { pkgs, ... }:
    {
      # FIXME: suggested by manual, but results in infinite recursion
      # nixpkgs.overlays = [
      #   (final: prev: {
      #     inherit (prev.lixPackageSets.stable)
      #       nixpkgs-review
      #       nix-eval-jobs
      #       nix-fast-build
      #       colmena
      #       ;
      #   })
      # ];

      nix.package = pkgs.lixPackageSets.stable.lix;
    };
}
