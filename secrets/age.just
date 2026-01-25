prj-root := env("PRJ_ROOT")
keys-dir := prj-root / "src/meta/data/keys"

[doc("Ensure age public keys for all Dotfield SSH public keys")]
convert-ssh-keys:
    for key in `fd -t f -e pub -E '*-rsa.pub' '.' {{ keys-dir }}/ssh/`; do \
        printf '{ssh => age}/{{ BOLD }}%s{{ NORMAL }}.{pub => txt}...\n' "`basename $key '.pub'`"; \
        ssh-to-age -i "$key" -o {{ keys-dir }}/age/`basename "$key" '.pub'`.txt; \
    done

[doc("Copy the age secret key from the password-store into place")]
install-key:
    mkdir -p $SOPS_AGE_KEY_DIR
    pass show age--secret-key >> $SOPS_AGE_KEY_FILE

from-ssh-key key="~/.ssh/id_ed25519":
    mkdir -p $SOPS_AGE_KEY_DIR
    ssh-to-age -private-key -i {{ key }} > $SOPS_AGE_KEY_DIR/age-key.sec
    ssh-to-age -i {{ key }}.pub > $SOPS_AGE_KEY_DIR/age-key.pub
