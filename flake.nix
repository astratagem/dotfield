{
  description = "Dotfield";

  outputs =
    inputs@{ nixpkgs, flake-parts, ... }:
    (flake-parts.lib.mkFlake { inherit inputs; } (
      { config, ... }:
      {
        debug = true;

        systems = [
          "aarch64-linux"
          "x86_64-linux"
        ];

        imports = [
          inputs.flake-parts.flakeModules.modules
          inputs.git-hooks.flakeModule

          ./src
          ./dev
          ./tests

          ./hive.nix
        ];

        perSystem =
          { system, pkgs, ... }:
          {
            _module.args = {
              pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
              };
            };
            formatter = pkgs.nixfmt-rfc-style;
          };
      }
    ));

  inputs = {

    ##: channels
    nixpkgs.follows = "nixos-unstable";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixos-unstable.url = "github:montchr/nixpkgs/nixos-unstable";
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-trunk.url = "github:NixOS/nixpkgs/master";
    nixpkgs-apple-silicon.follows = "nixos-apple-silicon/nixpkgs";

    ##: core libraries
    apparat.url = "github:montchr/apparat";
    dmerge = {
      url = "github:divnix/dmerge";
      inputs.haumea.follows = "haumea";
      inputs.nixlib.follows = "nixpkgs-lib";
    };
    haumea.url = "github:nix-community/haumea";
    flake-parts.url = "github:hercules-ci/flake-parts";
    globset = {
      url = "github:pdtpartners/globset";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };
    nixpkgs-lib.follows = "flake-parts/nixpkgs-lib";

    ##: core modules
    beams.url = "github:kleinweb/beams";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixos-unstable";

    ##: hardware
    nixos-apple-silicon = {
      # url = "github:nix-community/nixos-apple-silicon";
      url = "github:montchr/nixos-apple-silicon/dev";
      inputs.nixpkgs.follows = "nixos-unstable";
    };
    asahi-tuuvok-firmware.url = "git+ssh://git@codeberg.org/astratagem/asahi-tuuvok-firmware.git";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    ##: ops
    colmena.url = "github:zhaofengli/colmena";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-unit = {
      url = "github:nix-community/nix-unit";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    sops-nix.url = "github:Mic92/sops-nix";

    ##: customisation
    base16-schemes.url = "github:montchr/nix-base16-schemes";
    base16-schemes.inputs.nixpkgs.follows = "nixpkgs";
    ironbar = {
      # url = "github:JakeStanger/ironbar";
      # TODO: https://github.com/JakeStanger/ironbar/pull/1299
      url = "github:astratagem/ironbar?ref=astratagem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:YaLTeR/niri";
      # It is important to keep the Mesa versions in sync.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      # It is important to keep the Mesa versions in sync.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";

    ##: apps/tools
    ceamx = {
      url = "github:montchr/ceamx";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.apparat.follows = "apparat";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    llm-agents.url = "github:numtide/llm-agents.nix";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    ##: system
    musnix.url = "github:musnix/musnix";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
