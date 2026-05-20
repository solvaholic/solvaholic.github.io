#!/usr/bin/env bash
# draft-from-session.sh - scaffold a draft post from an agent session summary
#
# Usage:
#   script/draft-from-session.sh "Post title" path/to/session-summary.md
#
# The session summary is inlined under an "## Notes" section as a starting
# point. Edit, prune, and ship. The post is created as a draft.

set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 \"Post title\" path/to/session-summary.md" >&2
  exit 64
fi

title="$1"
summary_file="$2"

if [[ ! -f "$summary_file" ]]; then
  echo "Session summary not found: $summary_file" >&2
  exit 66
fi

slug=$(echo "$title" \
  | tr '[:upper:]' '[:lower:]' \
  | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')
date=$(date +%Y-%m-%d)
post_path="content/posts/${date}-${slug}.md"

if [[ -e "$post_path" ]]; then
  echo "Post already exists: $post_path" >&2
  exit 73
fi

hugo new "posts/${date}-${slug}.md" > /dev/null

# Fix up archetype-generated front matter: pass the actual title and a
# clean slug instead of the kebab-cased filename derivation.
escaped_title=$(printf '%s' "$title" | sed -e 's/[&\\]/\\&/g' -e 's/"/\\"/g')
# macOS sed needs -i ''
sed -i '' \
  -e "s|^title: .*|title: \"${escaped_title}\"|" \
  -e "s|^slug: .*|slug: \"${slug}\"|" \
  "$post_path"

# Append the session notes under a "## Notes" section.
{
  echo
  echo "## TL;DR"
  echo
  echo "_One paragraph. What did I do and why does it matter?_"
  echo
  echo "## Notes"
  echo
  echo "<!-- Raw session summary below. Edit ruthlessly. -->"
  echo
  cat "$summary_file"
} >> "$post_path"

echo "Created draft: $post_path"
echo "Next:"
echo "  - Edit $post_path"
echo "  - make serve   # preview"
echo "  - Set draft: false in front matter when ready"
