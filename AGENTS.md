# v-stakeholder AGENTS

- Preserve imported Rust history and provenance.
- Current phase target: compiled deterministic `classic-six + modern-core` with grouped fallback for later families.
- CLI contract: `--list-values`, `--focus-family`, `--output-format`, `--seed`, and explicit `--experimental-provider` fail-fast.
- Native validation uses pinned V 0.5.2 across Linux, macOS, and Windows.
- Docker builds V from the pinned upstream release commit and runs the CLI contract tests.
- Missing behavior must fail fast and remain documented in `GAPS.md`.
- Full live-provider/runtime support remains a required second-pass wave.
