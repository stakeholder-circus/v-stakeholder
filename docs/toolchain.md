# Toolchain

V native validation uses the Homebrew `vlang` compiler on arm64 macOS.

## Proven commands

- `v version`
- `v fmt -verify src/main.v`
- `v -gc none -o bin/stakeholder src/main.v`
- `make compiler-proof`
- `make test`

Toolchain source: Homebrew bottled `vlang` 0.5.1. The native binary is compiled with `-gc none` because the default Homebrew V compiler attempted to link `libgc` on this host. Docker, Nix, and third-party V packages are not required for the current deterministic first tranche.
