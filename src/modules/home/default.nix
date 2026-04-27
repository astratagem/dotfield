{
  inputs,
  config,
  flake-parts-lib,
  withSystem,
  ...
}:
let
  inherit (flake-parts-lib) importApply;
  inherit (inputs.apparat.lib) isEmpty;
in
{
  flake.modules.homeManager = {
    bash-trampoline = ./programs/bash/trampoline/_module.nix;
    blesh = importApply ./programs/bash/blesh/_module.nix {
      inherit isEmpty;
    };
    fzf-tab-completion = importApply ./programs/fzf-tab-completion/_module.nix {
      inherit withSystem;
    };
    jujutsu-signing = importApply ./programs/jujutsu/signing/_module.nix {
      inherit (config) meta;
    };
    kanata = ./services/kanata/_module.nix;
  };
}
