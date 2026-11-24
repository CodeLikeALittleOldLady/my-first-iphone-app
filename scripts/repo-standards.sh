#!/usr/bin/env bash
# Applies Alison's standard repo settings, copied from HumanEmpireHistory and earthcent-review-desk.
# Usage:  bash scripts/repo-standards.sh        (defaults to my-first-iphone-app)
#         bash scripts/repo-standards.sh OWNER/REPO (any other repo)
# Needs the GitHub CLI (gh), signed in with: gh auth login
set -euo pipefail
REPO="${1:-CodeLikeALittleOldLady/my-first-iphone-app}"
R="repos/$REPO"

echo "1. dev branch"
if ! gh api "$R/branches/dev" --silent 2>/dev/null; then
  BASE=$(gh api "$R" --jq .default_branch)
  SHA=$(gh api "$R/git/ref/heads/$BASE" --jq .object.sha)
  gh api -X POST "$R/git/refs" -f ref=refs/heads/dev -f sha="$SHA" --silent
fi

echo "2. dev as default, all three merge methods, keep branches after merge"
gh api -X PATCH "$R" -f default_branch=dev \
  -F allow_merge_commit=true -F allow_squash_merge=true -F allow_rebase_merge=true \
  -F delete_branch_on_merge=false -F allow_auto_merge=false --silent

# Safe to re-run: updates a ruleset with the same name if it exists, creates it otherwise.
ruleset() {
  local id method endpoint
  id=$(gh api --paginate "$R/rulesets?includes_parents=false" --jq ".[] | select(.name == \"$1\") | .id" | head -n1)
  if [ -n "$id" ]; then method=PUT; endpoint="$R/rulesets/$id"; else method=POST; endpoint="$R/rulesets"; fi
  gh api -X "$method" "$endpoint" --silent --input - <<JSON
{"name":"$1","target":"branch","enforcement":"active","bypass_actors":[],
 "conditions":{"ref_name":{"include":["$2"],"exclude":[]}},
 "rules":[{"type":"deletion"},{"type":"non_fast_forward"},
  {"type":"pull_request","parameters":{"allowed_merge_methods":["merge","squash","rebase"],
   "dismiss_stale_reviews_on_push":true,"require_code_owner_review":false,
   "require_last_push_approval":false,"require_extra_approval_for_unattributed_changes":true,"required_approving_review_count":0,
   "required_review_thread_resolution":false}}]}
JSON
}
echo "3. rulesets: Protect dev, Protect main"
ruleset "Protect dev"  "~DEFAULT_BRANCH"
ruleset "Protect main" "refs/heads/main"

echo "Done. Check: Settings > Rules > Rulesets on $REPO"
