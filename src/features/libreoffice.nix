{
  aspects.workstation.nixos = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.libreoffice-fresh
      pkgs.hunspell
      pkgs.hunspellDicts.en-us
      pkgs.hunspellDicts.de-de
    ];
  };
}
