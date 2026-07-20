{ lib, ... }: {
  nix = {
    ## `nix store optimise`
    settings.auto-optimise-store = false;
    optimise.automatic = true;

    ## `nix store gc`
    gc.dates = lib.mkDefault "weekly";
    gc.automatic = lib.mkDefault true;
  };
}
