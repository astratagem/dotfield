prj-root := env("PRJ_ROOT")

rotate-keys:
    for f in `fd -e yaml secrets {{ prj-root }}`; do sops -r "$f"; done

update-keys:
    for f in `fd -e yaml secrets {{ prj-root }}`; do sops updatekeys "$f"; done
