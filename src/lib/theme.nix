# SPDX-FileCopyrightText: Copyright (c) 2023 Chris Montgomery <chmont@proton.me>
# SPDX-FileCopyrightText: Copyright (c) 2019 Robert Helgesson
# SPDX-License-Identifier: GPL-3.0-or-later OR MIT
{ lib, inputs, ... }:
let
  inherit (inputs.apparat.lib.color) derivePolarity fromHex;

  # TODO: prob more useful to expand scope as a general colorscheme getter since
  #       even with this fn it's pretty repetitive
  asHexStrings = lib.mapAttrs (_: v: v.hex.r + v.hex.g + v.hex.b);

  /*
    # Type

    ```
    mkColor :: String -> {
      hex :: String,
      dec :: {
        r :: Int,
        g :: Int,
        b :: Int
      }
    }
    ```
  */
  mkColor = v: {
    hex = v;
    rgb = {
      r = fromHex lib.substring 0 2 v;
      g = fromHex lib.substring 2 2 v;
      b = fromHex lib.substring 4 2 v;
    };
  };

  /*
    Reshape a Base16 color scheme from its canonical form into the shape expected by our theme module.

    ## Types

    mkColorScheme :: { ${n} :: String } -> {
      name :: String,
      colors :: ColorScheme,
      variant :: String
    }
  */
  mkColorScheme =
    scheme:
    let
      bases = lib.filterAttrs (n: _: lib.hasPrefix "base" n) scheme;
      palette = lib.mapAttrs (_: mkColor) bases;
    in
    {
      inherit palette;
      # FIXME: `name` should be the yaml basename
      name = lib.replaceStrings [ " " ] [ "-" ] scheme.scheme;
      variant = derivePolarity palette.base00.rgb;
    };

  toColorSchemePath = pkgs: scheme: "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";

  # Build-time theme polarity, chosen via the `DOTFIELD_POLARITY` environment
  # variable (defaults to "dark").  This replaces the former dark/light NixOS and
  # Home-Manager specialisations: rather than pre-building both variants into
  # every generation (~3x the evaluation cost), we evaluate a single active
  # theme.  Switching theme means setting the variable and rebuilding, which the
  # `.justfile` `dark`/`light` recipes automate.
  #
  # NOTE: reading the environment makes evaluation impure with respect to
  # `DOTFIELD_POLARITY`.  This is fine for the `nh`/path-flake invocation used
  # here (already impure), but means `nix flake check` and other pure-eval
  # contexts always see the "dark" default.
  polarity =
    let
      env = builtins.getEnv "DOTFIELD_POLARITY";
    in
    if env == "" then "dark" else env;
in
{
  flake.lib.theme = {
    inherit
      asHexStrings
      mkColorScheme
      polarity
      toColorSchemePath
      ;
  };
}
