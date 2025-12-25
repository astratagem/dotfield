# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2025-11-15

### Added
- Automatic folder name prefix in window titles for better context
- Current working directory's folder name now appears before task description
- Format: `[Folder Name] | Task Description` or `[Prefix] | [Folder Name] | Task Description` with CLAUDE_TITLE_PREFIX

### Changed
- Window titles now include the current folder name for easier terminal identification
- Updated set_title.sh to automatically detect and prepend folder name using `basename "$PWD"`

## [1.1.0] - 2025-01-07

### Added
- Optional customization via `CLAUDE_TITLE_PREFIX` environment variable
- LICENSE file (MIT License)
- VERSION file for semantic versioning
- CHANGELOG.md to track version history
- Explicit task switching examples in SKILL.md
- "Common Mistakes to Avoid" section with negative examples
- Enhanced terminal type detection in set_title.sh

### Changed
- Improved error handling in set_title.sh with fail-safe behavior
- Enhanced SKILL.md with more detailed usage guidelines
- Updated script to exit silently instead of showing error message
- Better terminal compatibility with explicit case handling

### Fixed
- Error suppression for unsupported terminal types
- More robust terminal detection logic

## [1.0.0] - 2025-01-07

### Added
- Initial release
- Automatic terminal title updates based on Claude Code tasks
- SKILL.md with clear usage instructions
- set_title.sh script for setting terminal titles
- Support for macOS Terminal, iTerm2, Alacritty, and other ANSI-compatible terminals
- 40-character title limit for readability
- Format pattern: [Action/Category]: [Specific Focus]
