# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Compare two reduced `fileSystems` attrsets: $a (running config) against
# $b (disko layout).
#
# `defaults` is nixpkgs filler, not a real mount option.  Devices are reported
# but never fail the check: disko names the same device differently
# (/dev/mapper/<luks> vs /dev/disk/by-label/<label>) -- review by eye.
#
# Emits one line per finding, then a trailing VERDICT line carrying the count
# of findings that should fail the check.

def opts: (.options // []) - ["defaults"] | sort;
def pad($s): ($s + "        ")[0:8];

[ ($a + $b | keys[]) | . as $mp | ($a[$mp]) as $x | ($b[$mp]) as $y
  | if $x == null or $y == null
    then [{ kind: "MISSING", mp: $mp,
            msg: "absent from \(if $x == null then "running config" else "disko layout" end)" }]
    else
      [ (if $x.fsType != $y.fsType then
           { kind: "DIFF", mp: $mp, msg: "fsType: \($x.fsType) (running) vs \($y.fsType) (disko)" }
         else empty end),
        (if ($x | opts) != ($y | opts) then
           { kind: "DIFF", mp: $mp, msg: "options: \($x | opts | join(",")) (running) vs \($y | opts | join(",")) (disko)" }
         else empty end),
        (if $x.device != $y.device then
           { kind: "NOTE", mp: $mp, msg: "device: \($x.device) (running) vs \($y.device) (disko)" }
         else empty end) ]
      | if length == 0 then [{ kind: "OK", mp: $mp, msg: "" }] else . end
    end ]
| add as $rows
| ( $rows[] | "\(pad(.kind))\(.mp) \(.msg)" | rtrimstr(" ") ),
  "VERDICT \($rows | map(select(.kind == "DIFF" or .kind == "MISSING")) | length)"
