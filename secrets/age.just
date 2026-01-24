[doc: "Copy the age secret key from the password-store into place"]
install-key:
  mkdir -p $SOPS_AGE_KEY_DIR
  pass show age--secret-key >> $SOPS_AGE_KEY_FILE

from-ssh-key key="~/.ssh/id_ed25519":
  mkdir -p $SOPS_AGE_KEY_DIR
  ssh-to-age -private-key -i {{ key }} > $SOPS_AGE_KEY_DIR/age-key.sec
  ssh-to-age -i {{ key }}.pub > $SOPS_AGE_KEY_DIR/age-key.pub
