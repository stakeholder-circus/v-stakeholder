# Docker validation is intentionally deferred for this M1-safe local V tranche.
# The native validation lane uses Homebrew V on macOS.
FROM alpine:3.20
CMD ["sh", "-c", "echo 'Docker validation deferred for v-stakeholder'; exit 1"]
