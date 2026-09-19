# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  lib,
  self,
  inputs,
  config,
  withSystem,
  ...
}:
let
  inherit (lib) mkOption types;
  inherit (lib)
    elem
    head
    filter
    tail
    map
    ;

  flakeSpecialArgs = {
    inherit self inputs config;
  };

  flakeSpecialArgs' =
    system:
    withSystem system (
      ctx@{ config, inputs', ... }:
      let
        perSystem = {
          inherit (ctx.config) legacyPackages packages;
          inherit inputs';
        };
      in
      flakeSpecialArgs // { inherit perSystem; }
    );

  /**
    collectClassModules :: String -> { ${class} :: Module } -> [ Module ]
  */
  collectClassModules = class: lib.foldr (v: acc: acc ++ (v.${class}.imports or [ ])) [ ];
  collectNixosModules = collectClassModules "nixos";
  collectHomeModules = collectClassModules "home";

  # Collects overlays from a list of aspects.
  # self.overlays.default should be appended last at the call site to allow overrides.
  collectOverlays = lib.foldr (v: acc: acc ++ (v.overlays or [ ])) [ ];

  collectNameMatches =
    own: others: own |> (map (v: others.${v.name} or null)) |> filter (v: v != null);

  collectAspectDeps =
    stack: requestors:
    let
      rootNames = lib.catAttrs "name" requestors;
      op =
        visited: toVisit:
        if toVisit == [ ] then
          visited
        else
          let
            cur = head toVisit;
            rest = tail toVisit;
          in
          if elem cur.name (map (v: v.name) visited) then
            op visited rest
          else
            let
              deps = map (name: stack.${name}) (cur.requires or [ ]);
            in
            op (op visited deps ++ [ cur ]) rest;
    in
    (op [ ] requestors) |> filter (v: !(lib.elem v.name rootNames));

  resolveUserAspects =
    {
      username,
      hostedUserSpec,
      hostAspects,
    }:
    let
      userAspects = config.users.${username}.aspects;
      userAspectDeps =
        (collectAspectDeps config.aspects hostedUserSpec.aspects)
        ++ (collectAspectDeps userAspects hostedUserSpec.aspects);
      userExtensiveAspects = collectNameMatches (
        hostAspects ++ hostedUserSpec.aspects ++ userAspectDeps
      ) userAspects;
      userExtensiveAspectsDeps = collectAspectDeps config.aspects userExtensiveAspects;
    in
    hostedUserSpec.aspects
    ++ userAspectDeps
    ++ userExtensiveAspects
    ++ userExtensiveAspectsDeps
    ++ [ (userAspects.core or { }) ];

  resolveUserHomeModules =
    {
      username,
      hostedUserSpec,
      hostAspects,
      baseHomeModules,
    }:
    let
      resolvedUserAspects = resolveUserAspects {
        inherit username hostAspects hostedUserSpec;
      };
    in
    baseHomeModules
    ++ (collectHomeModules hostAspects)
    ++ (collectHomeModules resolvedUserAspects)
    ++ (collectHomeModules config.users.${username}.baseline.aspects)
    ++ [ hostedUserSpec.configuration ];

  # Resolves all overlays for a user's standalone Home Manager configuration.
  resolveUserOverlays =
    {
      username,
      hostedUserSpec,
      hostAspects,
    }:
    let
      resolvedUserAspects = resolveUserAspects {
        inherit username hostAspects hostedUserSpec;
      };
    in
    (collectOverlays hostAspects)
    ++ (collectOverlays resolvedUserAspects)
    ++ (collectOverlays config.users.${username}.baseline.aspects)
    ++ [ self.overlays.default ];

  mkDeferredModuleOpt =
    description:
    mkOption {
      inherit description;
      type = types.deferredModule;
      default = { };
    };

  aspectSubmoduleGenericOptions = {
    # TODO: accept actual aspect shape
    requires = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "List of names of aspects required by this aspect";
    };
    overlays = mkOption {
      type = types.listOf (types.functionTo (types.functionTo types.attrs));
      default = [ ];
      description = "Nixpkgs overlays required by this aspect";
    };
    nixos = mkDeferredModuleOpt "A NixOS module for this aspect";
    home = mkDeferredModuleOpt "A Home-Manager module for this aspect";
  };

  mkAspectNameOpt =
    name:
    mkOption {
      type = types.str;
      default = name;
      readOnly = true;
      internal = true;
    };

  mkAspectListOpt =
    description:
    mkOption {
      type = types.listOf (
        types.submodule {
          options = aspectSubmoduleGenericOptions // {
            # This differs from the `options.aspects.*.name` option
            # declaration in that it avoids setting a default value
            # inherited from the submodule's `name` argument.  We avoid
            # using `name` in this list context because it will not
            # reflect the original value of `name` as inherited from the
            # attrset where the aspect was originally defined -- the
            # latter `name` is what we want, not the anonymous `name`
            # from the list context.
            #
            # How does this not result in an error, you ask?  Because,
            # given project conventions, we *always* create an aspect
            # list from existing attributes where the desired name has
            # already been defined.  `name` is sneakily set to the
            # original value because of this.  If, for some reason, you
            # were to manually define an aspect inside of an option
            # declared with this function (don't!), you would indeed run
            # into an error, and you would need to set `name` manually.
            #
            # TODO: investigate the module system's esoteric `key` here
            name = mkOption {
              type = types.str;
              readOnly = true;
              internal = true;
              description = "Name of the aspect";
            };
          };
        }
      );
      default = [ ];
    };
in
{
  flake.lib.modules = {
    inherit
      aspectSubmoduleGenericOptions
      collectAspectDeps
      collectClassModules
      collectHomeModules
      collectNameMatches
      collectNixosModules
      collectOverlays
      flakeSpecialArgs
      flakeSpecialArgs'
      mkAspectListOpt
      mkAspectNameOpt
      mkDeferredModuleOpt
      resolveUserAspects
      resolveUserHomeModules
      resolveUserOverlays
      ;
  };
}
