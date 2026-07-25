{ config, ... }:
let
  inherit (config) meta;
in
{
  users.seadoom = {
    aspects.core.home = {
      sops.defaultSopsFile = ../cdom/secrets/secrets.yaml;
    };
  };
  meta.users.seadoom = meta.users.cdom;
}
