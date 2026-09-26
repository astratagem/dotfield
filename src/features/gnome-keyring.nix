{
  aspects.graphical.nixos = { pkgs, ... }: {
    services.gnome.gnome-keyring.enable = true;
    environment.systemPackages = [ pkgs.seahorse ];

    xdg.portal.extraPortals = [ pkgs.gnome-keyring ];
    xdg.portal.config.common = {
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };

    # Ensure keyring is unlocked upon login.
    security.pam.services.login.enableGnomeKeyring = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
