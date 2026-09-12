import "./common.vars.just"

[working-directory(user-configs-dir)]
default scope:
    stow -R {{ scope }}

[working-directory(user-configs-dir)]
all *FLAGS:
    fd -t d -d 1 -X stow -R {{ FLAGS }} '{.}'
