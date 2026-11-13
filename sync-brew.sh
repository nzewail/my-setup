#!/usr/bin/env bash
set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export HOME="${HOME:-/Users/nabeelz}"
export GIT_SSH_COMMAND="ssh -o BatchMode=yes"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCK_DIR="/tmp/my-setup-brew-sync.lock"
COMMIT_EMAIL="nabeelzewail@gmail.com"

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  exit 0
fi
trap 'rmdir "$LOCK_DIR" 2>/dev/null || true' EXIT

brew bundle dump --taps --brews --casks --force --file="$REPO_DIR/Brewfile"

if [[ -n "$(git -C "$REPO_DIR" status --porcelain Brewfile)" ]]; then
  git -C "$REPO_DIR" add Brewfile
  git -C "$REPO_DIR" -c user.email="$COMMIT_EMAIL" commit -m "chore: sync Brewfile"
fi

UNPUSHED=$(git -C "$REPO_DIR" rev-list --count '@{u}..HEAD' 2>/dev/null || echo 0)
if [[ "$UNPUSHED" -gt 0 ]]; then
  if ! git -C "$REPO_DIR" push; then
    git -C "$REPO_DIR" pull --rebase
    git -C "$REPO_DIR" push
  fi
fi
