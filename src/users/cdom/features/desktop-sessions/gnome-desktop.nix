{ self, ... }:
let
  inherit (self.lib) mimeapps mimetypes;
in
{
  users.cdom.aspects.desktop-sessions__gnome.home =
    { lib, config, ... }:
    let
      inherit (lib.hm.gvariant) mkUint32;
    in
    {
      xdg.mimeApps.defaultApplications = (mimetypes.genAssoc mimetypes.image mimeapps.nameFor "loupe");

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          clock-show-seconds = false;
          clock-show-weekday = true;
        };

        "org/gnome/desktop/media-handling" = {
          autorun-never = true;
        };

        "org/gnome/desktop/search-providers" = {
          sort-order = [
            (mimeapps.nameFor "nautilus")
            "org.gnome.Documents.desktop"
          ];
        };

        "org/gnome/desktop/session" = {
          # TODO: longer for home theater, which are the primary gnome users
          idle-delay = (mkUint32 600);
        };

        "org/gnome/shell/app-switcher" = {
          current-workspace-only = false;
        };

        "org/gnome/mutter" = {
          dynamic-workspaces = true;
          edge-tiling = true;
          # focus-change-on-pointer-rest = true;
          # workspaces-only-on-primary = true;
        };

        "org/gnome/desktop/wm/preferences" = {
          auto-raise = true;
          button-layout = "appmenu:minimize,close";
          focus-mode = "click";
          num-workspaces = 2;
        };

        "org/gnome/desktop/privacy" = {
          old-files-age = mkUint32 30;
          recent-files-max-age = -1;
        };

        "org/gnome/desktop/peripherals/keyboard" = {
          repeat = true;
        };
      };
    };
}
