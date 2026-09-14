import "../common.vars.just"

fs-commands-regexp := 'sgdisk[^|]*|mkfs\.[a-z0-9]+[^|]*|luksFormat|btrfs subvolume create[^|]*'

[doc("Compare a host's disko layout against its existing filesystem config")]
diff host:
    {{ module_directory() }}/diff/disko-diff.sh "{{ host }}"

[doc("Print the script disko would run for a host")]
print-script host:
    @nix build --no-link --print-out-paths \
        "{{ prj-root }}#nixosConfigurations.{{ host }}.config.system.build.diskoScript"

# FIXME: currently broken -- disko feeds an `aggregateModules` tree to vmTools
# as its `kernel` argument, which our nixpkgs rejects:
#   vmTools: the kernel argument (kernel-modules) has no target attribute
[doc("Boot a scratch VM to test a host's disko layout")]
boot-vm host:
    nix run -L "{{ prj-root }}#nixosConfigurations.{{ host }}.config.system.build.vmWithDisko"
