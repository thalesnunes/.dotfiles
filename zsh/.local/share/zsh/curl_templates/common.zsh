#!/usr/bin/env zsh

set -euo pipefail

die() {
  print -u2 -- "Error: $*"
  exit 1
}

require_cmd() {
  local cmd="$1"
  command -v "$cmd" >/dev/null 2>&1 || die "Missing required command: $cmd"
}

require_env() {
  local var_name="$1"
  local value="${(P)var_name:-}"
  [[ -n "$value" ]] || die "Missing required env var: $var_name"
}

default_thread_id() {
  print -- "req-test-$(date +%s)"
}

default_user_email() {
  print -- "${USER_EMAIL:-svcacct-looker+cachemanager@upwork.com}"
}

json_post() {
  local url="$1"
  shift
  curl -sS --fail-with-body -X POST "$url" \
    -H "Content-Type: application/json" \
    "$@"
}

