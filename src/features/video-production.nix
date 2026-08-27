{
  aspects.video-production.nixos = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.davinci-resolve
      pkgs.flowblade
    ];
  };
}
