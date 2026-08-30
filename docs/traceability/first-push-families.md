# First push families

This tranche ports the deterministic family-focus contract into a compiled V runtime.

| Family group | V path | Source reference | Parity class |
| --- | --- | --- | --- |
| classic-six | `src/main.v` | current deterministic CLI family registry and smoke-contract shape | dedicated |
| modern-core | `src/main.v` | current deterministic CLI family registry and smoke-contract shape | dedicated |
| later families | `src/main.v` | grouped fallback policy in current deterministic repos | grouped fallback |
| CLI contract | `src/main.v`, `tests/test_cli.sh` | small-tranche smoke contract | deterministic |
| experimental provider | `src/main.v`, `tests/test_cli.sh` | fail-fast provider policy | explicit fail-fast |

Rust and Java remain canonical behavioral anchors; this V tranche is published with native and Docker validation gates.
