{
  users.cdom.aspects.graphical.home = {
    programs.ghostty = {
      settings = {
        confirm-close-surface = false;

        # Ensure a predictable font width.
        font-family = "Iosevka Term";

        # Incompatible with `window-inherit-working-directory`.
        # <https://github.com/ghostty-org/ghostty/discussions/4123#discussioncomment-13433453>
        gtk-single-instance = false;

        # Prevent link preview overlay from obscuring the prompt when
        # briefly holding Ctrl when the mouse cursor just so happens to
        # be hovering over a link unintentionally.  This behavior can
        # feel slightly frustrating when using readline keybindings
        # (e.g. Ctrl+W) to edit the command line i.e. when actively
        # typing and not using the mouse.
        link-previews = false;

        window-decoration = false;
        window-inherit-working-directory = true;
        working-directory = "inherit";
      };
    };
  };
}
