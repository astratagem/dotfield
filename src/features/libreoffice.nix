{
  aspects.workstation.nixos = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.libreoffice-fresh
      pkgs.hunspell
      pkgs.hunspellDicts.en-us
      pkgs.hunspellDicts.de-de
    ];
  };

  aspects.workstation.home = { lib, pkgs, ... }: {
    # Some LibreOffice extensions may require the Java Runtime
    # Environment (JRE).  Unfortunately, this must be configured in the
    # GUI settings with a stable path.
    # <https://wiki.nixos.org/wiki/Zotero#Zotero_LibreOffice_add-on>
    home.file.".local/share/java/jre8".source = pkgs.jre8;
  };
}
