#!/usr/bin/env bash
# ghx gateway checks, next to the template-owned scripts/doctor.sh.
#
# doctor.sh is stamped by the agentic template and must not carry
# repo-local checks, so the gateway checks live here: ghx always;
# backend deps per the repo's forge host (github remote -> gh; anything
# else -> curl+jq+token for Forgejo REST). Run it after doctor.sh.
set -u

warn_tool() {
    local tool=$1
    local message=$2
    if command -v "$tool" >/dev/null 2>&1; then
        echo "✓ $tool"
    else
        echo "⚠ $tool — $message"
    fi
}

echo "ghx gateway:"
warn_tool ghx "not on PATH — agents cannot reach the forge gateway"
remote_url="$(git remote get-url origin 2>/dev/null || true)"
if [[ "$remote_url" == *github.com* ]]; then
    warn_tool gh "github remote detected but gh is missing"
elif [[ -n "$remote_url" ]]; then
    warn_tool curl "forgejo remote detected but curl is missing"
    warn_tool jq "forgejo remote detected but jq is missing"
    if [[ -n "${GHX_FORGEJO_TOKEN:-}" ]]; then
        echo "✓ GHX_FORGEJO_TOKEN"
    else
        echo "⚠ GHX_FORGEJO_TOKEN — not set; forgejo backend calls will fail"
    fi
fi
