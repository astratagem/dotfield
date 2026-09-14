import "../common.vars.just"

[doc("Build the bootable installer ISO")]
build *ARGS='':
    nix build "{{ prj-root }}#installer-iso" --print-out-paths {{ ARGS }}

[doc("Write a built ISO to a block device (DESTROYS the target device)")]
[arg("iso", help="Absolute path to the ISO file")]
[arg("device", help="Absolute path to the target device")]
[confirm("The target device will be ERASED!  Continue?")]
write iso device:
    test -e '{{ iso }}'
    test -b "{{ device }}"
    sudo dd if='{{ iso }}' of='{{ device }}' bs=4M status=progress oflag=sync
