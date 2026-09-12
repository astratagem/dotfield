# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# This cannot be autoloaded.
function __on_cd_list_contents --on-variable PWD
    eza --grid --icons=always
end
