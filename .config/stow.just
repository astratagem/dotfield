import "./common.vars.just"

alias default := restow

[working-directory(user-configs-dir)]
restow scope *ARGS:
    stow -R {{ ARGS }} {{ scope }}

[working-directory(user-configs-dir)]
all *ARGS:
    fd -t d -d 1 -X stow -R {{ ARGS }} '{.}'
