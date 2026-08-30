> [!WARNING]
> This repository is AI-assisted and manually reviewed. Its deterministic V tranche is published with explicit validation evidence.

# v-stakeholder

V implementation of the stakeholder deterministic first tranche.

## Current tranche

- Full dedicated `classic-six + modern-core` generator families.
- Grouped fallback for later generator families.
- Deterministic normalized JSON with same-seed stability.
- `--list-values`, `--focus-family`, `--output-format`, `--seed`, and explicit `--experimental-provider` fail-fast.
- Full live-provider/runtime support remains deferred to the later provider wave.

## Commands

- `python3 scripts/validate_scaffold.py`
- `make compiler-proof`
- `make test`
- `docker build -t v-stakeholder .`
- `docker run --rm v-stakeholder --list-values`

GitHub CI runs native Linux/macOS/Windows tests, `v vet`, Docker build/runtime
smokes, dependency review, actionlint, and workflow-security analysis.
