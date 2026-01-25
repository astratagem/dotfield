{
  aspects.core.nixos =
    { config, pkgs, ... }:
    {
      sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      # Required for sops-nix management.
      users.groups.keys = { inherit (config.users.groups.wheel) members; };

      environment.systemPackages = [
        pkgs.rage
        pkgs.sops
      ];
    };

  aspects.core.home =
    { config, ... }:
    let
      inherit (config.home) username;
    in
    {
      # Allow normal users to use sops.
      home.sessionVariables = {
        "AGE_KEY_DIR" = "$HOME/.age";
        "SOPS_AGE_KEY_DIR" = "$XDG_CONFIG_HOME/sops/age";
        "SOPS_AGE_KEY_FILE" = "$XDG_CONFIG_HOME/sops/age/keys";
      };

      sops.age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
      sops.defaultSopsFile = ../../users/${username}/secrets/secrets.yaml;
    };
}
