{ self, ... }: {
  aspects.core.nixos =
    { config, ... }:
    let
      githubToken = config.sops.placeholder."nix-config/access-tokens/github";
    in
    {
      sops.secrets."nix-config/access-tokens/github" = {
        sopsFile = "${self}/secrets/global.secrets.yaml";
      };

      sops.templates."nix-config-access-tokens.conf".content = ''
        access-tokens = github.com=${githubToken}
      '';

      nix.extraOptions = ''
        !include ${config.sops.templates."nix-config-access-tokens.conf".path}
      '';
    };
}
