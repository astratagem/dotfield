# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Reduce a `fileSystems` attrset to the fields the diff compares, so both
# sides of the comparison get shaped identically.
fs:
builtins.mapAttrs (_: v: {
  inherit (v) device fsType;
  options = v.options or [ ];
}) fs
