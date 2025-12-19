let
  desktopEntryNames = {
    file-roller = "org.gnome.FileRoller";
    ghostty = "com.mitchellh.ghostty";
    loupe = "org.gnome.Loupe";
    nautilus = "org.gnome.Nautilus";
    zathura = "org.pwmt.zathura-pdf-mupdf";
  };

  nameFor = app: (desktopEntryNames.${app} or app) + ".desktop";
in
{
  flake.lib.mimeapps = {
    inherit desktopEntryNames nameFor;
  };
}
