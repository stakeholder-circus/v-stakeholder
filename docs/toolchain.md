# Toolchain

V validation is pinned to upstream release commit
`7647ce1c6fad63b5578bc07883139906de74b2f8` (V 0.5.2).

## Native

- GitHub Actions uses `vlang/setup-v` at immutable SHA `663cc08827d1fc0532ee755b4dedbb183c11d06a`.
- Linux, macOS, and Windows run format, build, and CLI contract tests.
- `v vet src/main.v` is the language-native SAST gate.

## Docker

The multi-stage Alpine build compiles V from the pinned upstream commit, builds
with `-gc none`, runs the CLI tests, and copies only the resulting binary into a
non-root runtime image.
