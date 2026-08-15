---
name: reviewing-pull-requests
description: "Judge whether a completed change is ready to land: with fresh context, evaluate a PR or feature branch against its acceptance criteria, CI/checks, and code quality, then reach a verdict — recommend merge (and, from the repo root, clean up) or return blocking findings. Use when you need a fresh-eyes gate on a developer's finished work, a pre-PR self-check, or a decision on whether a branch is mergeable. Not for merging a change the user already reviewed, summarizing or explaining a PR, debugging its CI, or git surgery like rebasing or resolving conflicts — this skill decides readiness, it doesn't perform those edits. Never merges without explicit approval."
---

# Reviewing Pull Requests

This is the reviewer/gate role of the agentic SDLC. It looks at a change with fresh eyes — deliberately separate from the developer that wrote it — reaches a verdict, and then either reports findings and next steps or (when able) merges and cleans up. It is a gate, not a rubber stamp.

*Pipeline position: step 4 of 4 — upstream: `implementing-features`; downstream: `generating-tickets` (surfaced follow-ups feed back into the loop).*

You are typically pointed at the work a developer produced with `implementing-features`. If no PR/branch is given, ask which one before starting.

## Where this runs (two modes)

The **review logic is identical** in both modes — only the launch location and the post-verdict actions differ. Pick the mode from where you were launched:

- **Local (from the developer's workspace)** — a fast pre-PR self-check. Run a fresh-context **subagent within the developer's session** to review the live worktree + diff before a PR exists. This mode is **review-only**: it is inside the worktree, so it can *never* merge or remove the worktree. Its clean verdict is "ready — go open the PR"; its not-clean verdict hands findings back to the developer.
- **Remote (from the repository root)** — the authoritative merge gate. Review the **open PR** (diff + CI) with a fresh-context subagent at the root. Only this mode may merge the PR and tear down the developer's worktree + herdr workspace, because only the root sits outside the worktree.

If you need to merge/clean up but were launched locally, stop and hand off to a root-launched review — do not attempt it from the worktree.

## Scope

- Review one change (open PR in remote mode, or the live worktree/diff in local mode) against its ticket and the repo's own checks.
- Reach a clear verdict and present it.
- **Remote mode only:** on a clean verdict **and explicit approval**, merge the PR and tear down the developer's worktree + herdr workspace — all from the repository root.

Never do the following:

- Merge a PR before it is clean **and** the human has explicitly approved the merge.
- Merge or remove a worktree from inside it, or in local mode at all — those actions belong to a root-launched (remote) review.
- Rewrite the developer's code yourself. Report findings; let the developer or a follow-up ticket address them.

## Get fresh context

The point of this role is a review uncontaminated by the developer's reasoning. Do the review in a **fresh-context subagent** (the provider's native subagent/Task primitive — auggie, opencode, and claude each expose one), not in the context that implemented the change. A subagent gives a clean context window even when launched from the developer's own session (local mode).

- **Remote:** the subagent reads the PR through the repo's PR tool (`gh pr view <pr>`, `gh pr diff <pr>`, `gh pr checks <pr>`, or the tool `AGENTS.md` declares) — it does not need to `cd` into the worktree.
- **Local:** the subagent reads the live worktree (diff against the base branch, changed files, and can run the repo's checks) since the code is on disk.
- Either way, give the subagent only the change reference and the ticket (ID/link + acceptance criteria). Let it form its own conclusions.

## Orient

1. Read the repo's `AGENTS.md` (and nested ones) for build/test/lint commands, PR/merge conventions (squash/rebase/merge), the ticketing system, and any hard rules. These override anything here on conflict.
2. Read the PR: title, description, linked ticket, changed files, and the diff.
3. Recover the ticket's acceptance criteria — this is what the change is measured against.

## Review

Gate first (cheap, objective), then quality. Stop early if a gate fails.

### Gates

- **Acceptance criteria** — every criterion in the ticket is actually met by the diff, not merely claimed.
- **Checks / CI** — the repo's own checks pass on the PR head (`gh pr checks`, or the declared tooling). Do not treat a passing self-report as proof; confirm.

If a gate fails, stop the deep pass — the PR is not clean regardless of code quality.

### Quality lenses (applied to the diff)

Pass over the **changed lines** through each lens. Record concrete, located findings (file/line + why it matters), not vague impressions.

- **Correctness** — bugs, unhandled cases, broken invariants, flaky or missing tests for the new behavior.
- **Tech debt** — duplication, dead code, tangled modules, TODO/FIXME left behind.
- **Gaps** — incomplete flows, undocumented behavior, absent error handling introduced by the change.
- **Security** — exposed secrets, unsafe input handling, permission or auth gaps in the diff.
- **DX / maintainability** — unclear structure, weak or missing tests, conventions broken versus the surrounding code.

Classify each finding as **blocking** (must fix before merge) or **non-blocking** (nice-to-have / follow-up).

## Verdict

Present the verdict to the human. Two outcomes:

**Clean** — gates pass and there are no blocking findings. Summarize what was reviewed and why it's ready, and list any non-blocking follow-ups.
- **Local mode:** the verdict is "ready — open the PR" (the developer's PR-draft gate takes it from there). Do not merge or clean up.
- **Remote mode:** **recommend merge + cleanup**, then stop and ask for explicit approval before executing (see below).

**Not clean** — a gate failed or there are blocking findings. Do not merge. Summarize the findings (grouped, located, blocking vs non-blocking) and suggest next steps: hand back to the developer to address, or file follow-up tickets via `generating-tickets`. Leave the PR and worktree in place.

## Merge and cleanup (remote mode only, when clean and approved)

Execute only in remote mode, after the human explicitly approves, and only from the repository root. Never from inside the worktree.

1. **Merge** the PR using the repo's convention from `AGENTS.md` (`gh pr merge <pr> --squash|--rebase|--merge`, or the declared tool).
2. **Tear down the developer's herdr agent + workspace** — per the `herdr` skill (verify `HERDR_ENV=1`, find the `dev-<repo>-<slug>` agent/workspace, stop the agent, close its workspace). Do not hardcode Herdr command syntax; the installed binary is the authority.
3. **Remove the worktree** with worktrunk from the root, after confirming nothing is checked out there:
   ```bash
   wt remove <branch>   # worktrunk; run from the main checkout, not the worktree
   ```
4. Report back: merge result, workspace/agent torn down, worktree removed, and any non-blocking follow-ups left for later.

## Hard rules

- Never put secrets in review comments, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Never merge before a clean verdict **and** explicit human approval; CI + human review own the merge decision.
- Merge and worktree removal happen only in remote mode, from the repository root — never from inside the worktree, never in local mode.
- Do the review with fresh context (subagent), not the developer's context.

## Definition of Done

- Change reviewed against its acceptance criteria, the repo's checks, and the quality lenses — with fresh context, in the correct mode for where it was launched.
- A clear verdict presented: clean or not clean (findings + next steps).
- Local mode, clean: verdict is "ready — open the PR"; nothing merged or removed.
- Remote mode, clean and approved: PR merged per repo convention, developer's herdr agent + workspace torn down, worktree removed — all from the root — and results reported.
- If not clean: findings summarized with next steps; nothing merged or removed.

## Related

If the review surfaces work beyond this PR's scope, suggest running `generating-tickets` to capture it as new tickets. Do not auto-invoke it.
