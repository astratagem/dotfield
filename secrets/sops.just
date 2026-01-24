rotate-keys:
    fd -e yaml secrets -x sops -r '{}'

update-keys:
    fd -e yaml secrets -x sops updatekeys '{}'
