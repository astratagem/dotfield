{
  aspects.graphical.nixos = { pkgs, ... }: {
    services.gnome.gnome-keyring.enable = true;
    environment.systemPackages = [ pkgs.seahorse ];
    xdg.portal.config.common = {
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };
  };
}
