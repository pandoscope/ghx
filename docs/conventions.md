# ghx — Project Conventions

Repo-specific rules referenced from [AGENTS.md](../AGENTS.md). This file is
seeded once by the agentic template and never overwritten by `copier update` —
edit it freely.

## Doctor

`scripts/doctor.sh` is template-owned. The ghx gateway checks (ghx on
PATH, gh or curl+jq+token per the forge host) live in
`scripts/doctor.local.sh`; run it after doctor.sh.
