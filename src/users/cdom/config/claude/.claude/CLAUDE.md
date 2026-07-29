# Claude Memory Management

## General

- Always favor idiomatic approaches to code architecture and patterns
- Avoid generating or suggesting quick hacks unless the situation
  specifically warrants it (e.g. prototyping, experimenting)
- Comments should explain _why_, not _how_ (Jeff Atwood, "Code Tells You
  How, Comments Tell You Why"). The code already shows how it works; a
  comment that paraphrases the next line is noise that rots out of sync.
  Comments earn their place by capturing intent, rationale, non-obvious
  constraints, and tradeoffs — things the code cannot express. If code
  needs a comment to explain _what_ it does, prefer refactoring (better
  names, extracted functions) over annotating. Be terse.
  <https://blog.codinghorror.com/code-tells-you-how-comments-tell-you-why/>

## Nix

- Do not interact with the Nix store (`/nix/store`) as a filesystem
  (no `ls`, `find`, `cat`, etc. on store paths). Use `nix` commands
  instead — e.g. `nix eval`, `nix flake metadata`, `nix flake show`,
  `nix derivation show`, `nix-instantiate --eval`, `nix repl`. Store
  paths are an implementation detail and traversing them directly is
  slow, fragile, and not a supported interface.

## Communication style preferences

- Avoid exclamation points

## Rust

The user is currently beginner-level in Rust, and is trying to learn the
language by working on Rust projects.

When working on a Rust project:

- Your role, as a tutor, is to help the user learn Rust with hints,
  guidance, and learning opportunities.
- Do not offer to bulk generate or write code to files unless
  specifically asked by the user. You may still provide snippets in
  your responses.
- When asked directly about a technical aspect of Rust development
  (e.g. along the lines of “why is this necessary?” or “how does this
  work?”), it probably means the user is temporarily confused. In
  those cases, be forthcoming with helpful information in order to
  reduce the challenge the user is facing.
- Rust: I prefer small-ish modules with a descriptive focus.

## Android / Nix Cross-Compilation

### 16KB Page Alignment (Android 15+)

- Use `zipalign -p -f 4` to page-align .so files
- Newer build-tools (35+) may use `-P 16`, older (34.x) use `-p`
- This affects any app with native code on Android 15+

### NDK Version Compatibility

- NDK r27+ breaks gnulib (`mktime_z` undefined) - affects Emacs and
  possibly other GNU projects
- Stick with NDK r26 for GNU software
- Check NDK version: `cat $ANDROID_NDK_ROOT/source.properties`

### sharedUserId for App Storage Sharing

- Apps with same `sharedUserId` + same signing key can share `/data/data/`
- nix-on-droid has hardcoded `com.termux` assumptions
- Pattern: patch AndroidManifest.xml, re-sign with shared keystore
