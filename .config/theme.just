import "./common.vars.just"

# Build-time theme polarity, consumed by `self.lib.theme.polarity` during
# evaluation (see src/lib/theme.nix).  Exported so every rebuild recipe below
# sees a consistent value.  `just dark`/`just light` override it per-invocation;
# a plain `just switch` uses the ambient value, defaulting to "dark".
export DOTFIELD_POLARITY := env("DOTFIELD_POLARITY", "dark")

emacs-eval-cmd := "emacsclient --no-wait --eval"
gtk-ui-schema := "org.gnome.desktop.interface"

arg-kind-regexp := 'dark|light'

alias default := switch

[doc("Set the theme for all applications")]
[arg("kind", pattern=arg-kind-regexp, help="Color scheme polarity [default: dark]")]
switch kind='dark': && (wm-set-theme kind)
    DOTFIELD_POLARITY={{ kind }} nh os switch "{{ prj-root }}" -- --impure
    {{ emacs-eval-cmd }} '(ceamx-ui/{{ kind }})'

[doc("Use the 'light' theme for all applications")]
light: (switch "light")

[doc("Use the 'dark' theme for all applications")]
dark: (switch "dark")

[linux]
[private]
[doc("Get or set the GTK theme")]
[arg("command", pattern="get|set", help="Get or set [default: get]")]
[arg("kind", pattern=arg-kind-regexp)]
gtk-theme command='get' kind='':
    gsettings {{ command }} {{ gtk-ui-schema }} color-scheme \
      {{ if command == 'set' { "prefer-" + kind } else { '' } }}

[linux]
[private]
[doc("Switch the current GTK theme polarity")]
[arg("kind", pattern=arg-kind-regexp, help="Color scheme polarity [default: dark]")]
wm-set-theme kind="dark": (gtk-theme "set" kind)
