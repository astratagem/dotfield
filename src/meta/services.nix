# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, ... }:
let
  inherit (config.meta) networks;
in
{
  meta.services = {
    keycloak =
      let
        fqdn = "auth.${networks.seadome.domain}";
      in
      {
        inherit fqdn;
        realms.default = rec {
          name = "master";
          urls.base = "https://${fqdn}/realms/${name}";
          urls.oidc = "${urls.base}/protocol/openid-connect";
        };
      };
  };
}
