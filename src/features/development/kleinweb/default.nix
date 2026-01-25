{ inputs, ... }:
{
  aspects.development__kleinweb = {
    requires = [
      "development"
      "development__php"
    ];

    nixos = {
      imports = [
        inputs.beams.modules.nixos.default
      ];
    };

    home =
      { config, ... }:
      {
        imports = [
          inputs.beams.modules.homeManager.default
        ];

        sops.secrets = {
          "rclone/kleinit_onedrive/drive_id" = { };
          "rclone/kleinit_onedrive/token" = { };
          "rclone/tu_onedrive/drive_id" = { };
          "rclone/tu_onedrive/token" = { };
        };

        programs.rclone.remotes."kleinit-onedrive" = {
          config = {
            type = "onedrive";
            drive_type = "documentLibrary";
          };
          secrets = {
            drive_id = config.sops.secrets."rclone/kleinit_onedrive/drive_id".path;
            token = config.sops.secrets."rclone/kleinit_onedrive/token".path;
          };
        };

        programs.rclone.remotes."kleinweb-s3".config = {
          type = "s3";
          provider = "AWS";
          env_auth = true;
          region = "us-east-1";
        };

        programs.rclone.remotes."tu-onedrive" = {
          config = {
            type = "onedrive";
            drive_type = "business";
          };
          secrets = {
            drive_id = config.sops.secrets."rclone/tu_onedrive/drive_id".path;
            token = config.sops.secrets."rclone/tu_onedrive/token".path;
          };
        };
      };
  };
}
