{
  aspects.development.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.awscli2
        pkgs.aws-sso-cli
        pkgs.cli53
      ];
    };
}
