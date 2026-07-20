set no-cd := true

alias yml := yaml

cache-dir := env("PRJ_CACHE_HOME")
data-dir := env("PRJ_DATA_HOME")

dconf-dump-tmpfile := cache-dir / "dconf.settings"

all ext input-dir output-dir=data-dir:
  fd -t f -e {{ ext }} . {{ input-dir }} -x bash -c \
    'just nixify {{ ext }} {} | nixfmt > {{ output-dir }}/{/.}.nix'

[doc("Convert a YAML file to a Nix expression")]
yaml input: (_yaml-to-json input)
    just nixify json {{ cache-dir }}/{{ file_stem(input) }}.json
    @rm {{ cache-dir }}/{{ file_stem(input) }}.json

[doc("Convert a YAML file to JSON with yq")]
_yaml-to-json input:
    yq '.' {{ input }} > {{ cache-dir / file_stem(input) }}.json

# TODO: read from stdin... how?
[doc("Convert a JSON file to a Nix expression")]
json input:
    nix eval --expr 'builtins.fromJSON (builtins.readFile {{ input }})' --impure

[doc("Convert a TOML file to a Nix expression")]
toml input:
    nix eval --expr 'builtins.fromTOML (builtins.readFile {{ input }})' --impure

# <https://github.com/nix-community/dconf2nix>
[doc("Convert current dconf/GNOME/GTK/gsettings to a Nix expression")]
dconf: _dconf-dump
    dconf2nix -i {{ dconf-dump-tmpfile }} -o /dev/stdout

_dconf-dump:
    dconf dump / > {{ dconf-dump-tmpfile }}

_dconf-clean:
    crudini --del {{ dconf-dump-tmpfile }} org/blueman/plugins/autoconnect
