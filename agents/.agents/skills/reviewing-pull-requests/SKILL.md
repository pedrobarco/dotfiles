---
name: reviewing-pull-requests
description: "Judge whether a completed change is ready to land: with fresh context, evaluate a PR or feature branch against its acceptance criteria, CI/checks, and code quality, then reach a verdict — recommend merge (and, from the repo root, clean up) or return blocking findings. Use when you need a fresh-eyes gate on a developer's finished work, a pre-PR self-check, or a decision on whether a branch is mergeable. Not for merging a change the user already reviewed, summarizing or explaining a PR, debugging its CI, or git surgery like rebasing or resolving conflicts — this skill decides readiness, it doesn't perform those edits. Never merges without explicit approval."
---

# Reviewing Pull Requests

This is the reviewer/gate capability of the agentic SDLC. It looks at a change with fresh eyes — deliberately separate from the role that wrote it — reaches a verdict, and then either reports findings and next steps or (when able) merges and cleans up. It is a gate, not a rubber stamp.

You are pointed at either a change on a feature branch/worktree before a PR exists (local mode) or an open PR to gate (remote mode). If no PR/branch is given, ask which one before starting.

## Run context

The **review logic is identical** in both modes, which both run from the task's `<repo>-<slug>-plan` workspace at the repo root — only the subject reviewed and the post-verdict powers differ.

- **Role / model:** a **reviewer** role with **fresh context**, distinct from the implementer — the reserved `<repo>-<slug>-review` agent, on opencode the `reviewer` agent for local mode and the `pr-reviewer` agent for remote mode (both `augment/claude-opus-4-8-medium`, `edit: deny`); on cursor, Grok. Review-only; never edits code.
- **Location — both modes run from the task's `<repo>-<slug>-plan` workspace at the repo root:**
  - **Local** — a fast pre-PR self-check, run as a fresh-context subagent that reads the implementer's feature worktree + diff on disk (`git -C <worktree>`) before a PR exists. Launched either by a human or **auto-launched by `implementing-tasks`** once its branch is pushed (only when the task's `<repo>-<slug>-plan` workspace is live to route the verdict to). It never merges or removes the worktree. Clean verdict = "ready — open the PR"; not-clean hands findings back to `implementing-tasks`.
  - **Remote** — the authoritative merge gate reviewing the open PR (diff + CI) with a fresh-context subagent. Only this mode may merge the PR and tear down the worktree + `<repo>-<slug>-dev` workspace.
- **On entry:** read the repo's `AGENTS.md` and recover the ticket + acceptance criteria. Merge/cleanup happens only in remote mode; in local mode, always hand off rather than merge or tear down.

## Scope

- Review one change (open PR in remote mode, or the live worktree/diff in local mode) against its ticket and the repo's own checks.
- Reach a clear verdict and present it.
- **Remote mode only:** on a clean verdict **and explicit approval**, merge the PR and tear down the task's worktree + `<repo>-<slug>-dev` workspace — all from the repository root.

Never do the following:

- Merge a PR before it is clean **and** the human has explicitly approved the merge.
- Merge or remove a worktree in local mode — those actions belong to remote-mode review only.
- Rewrite the developer's code yourself. Report findings; let the developer or a follow-up ticket address them.

## Get fresh context

The point of this role is a review uncontaminated by the developer's reasoning. Do the review in a **fresh-context subagent** (the provider's native subagent/Task primitive — auggie, opencode, claude, and cursor each expose one), not in the context that implemented the change. A subagent gives a clean context window; the reviewer role is separate from the implementer in both modes.

- **Remote:** the subagent reads the PR through the repo's PR tool (`gh pr view <pr>`, `gh pr diff <pr>`, `gh pr checks <pr>`, or the tool `AGENTS.md` declares) — it does not need to `cd` into the worktree.
- **Local:** the subagent reads the live worktree (diff against the base branch, changed files, and can run the repo's checks) since the code is on disk.
- Either way, give the subagent only the change reference and the ticket (ID/link + acceptance criteria). Let it form its own conclusions.

## Orient

1. Read the repo's `AGENTS.md` (and nested ones — nearest up-tree wins) for the conventions this stage needs: **verify commands** (build/lint/test), the **PR tool**, the **merge strategy** (squash/rebase/merge), the **ticketing system**, and any hard rules. Read them by meaning, wherever the repo states them — don't require a dedicated block. `AGENTS.md` is the authority for these **mechanical conventions** and overrides this skill's defaults on conflict — but it does **not** override this skill's safety gates (never merge without a clean verdict *and* explicit approval, review with fresh context, cleanup only from root in remote mode, no secrets); a repo cannot, e.g., declare "auto-merge on green" to bypass the gate. If the repo has no `AGENTS.md` or is silent on a key, infer from repo signals (merge strategy from existing PR history, commands from a Makefile/justfile/package scripts); if still ambiguous, ask once rather than assume.
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
- **Local mode:** the verdict is "ready — open the PR" (`creating-pull-requests` takes it from there). Do not merge or clean up.
- **Remote mode:** **recommend merge + cleanup**, then stop and ask for explicit approval before executing (see below).

**Not clean** — a gate failed or there are blocking findings. Do not merge. Summarize the findings (grouped, located, blocking vs non-blocking) and suggest next steps: hand back to `implementing-tasks` to address, or file follow-up tickets via `generating-tickets`. Leave the PR and worktree in place.

## Merge and cleanup (remote mode only, when clean and approved)

Execute only in remote mode, after the human explicitly approves, and only from the repository root. Never from inside the worktree.

You review with fresh context, so you did **not** inherit the branch, slug, or `<repo>-<slug>-dev` workspace — recover them. The task shares one `<slug>` across every entity (`<repo>-<slug>-dev`, `<repo>-<slug>-review`), so recovering the slug recovers all the names. The **branch** is the PR head (`gh pr view <pr>` → head ref); the **worktree path** and the branch's `<repo>-<slug>-dev` workspace id both come from `herdr worktree list --json` (`.result.worktrees[]` matched by `.branch` → `.path` and `.open_workspace_id`) — or, for the path alone, `wt list --format json` (`.items[].worktree.path`, matched by `.items[].branch`); the `<slug>` is the branch/ticket slug. Confirm the live names against `herdr agent list` / `herdr workspace list` (matching the `<repo>-<slug>-dev` workspace on that worktree path) rather than assuming they are still running.

1. **Merge** the PR using the repo's convention from `AGENTS.md` (`gh pr merge <pr> --squash|--rebase|--merge`, or the declared tool).
2. **Remove the worktree, then close its workspace** — the inverse of how `implementing-tasks` created them, and exactly what the worktrunk plugin's remove does. Run from the root, after confirming nothing is checked out there:
   ```bash
   wt remove <branch>   # worktrunk owns the checkout, branch, teardown hooks, and safety gates; <branch> = the PR head recovered above; run from the main checkout, not the worktree
   ```
   Then close the now-empty `<repo>-<slug>-dev` workspace (its id recovered above) per the `herdr` skill — `herdr workspace close <id>`. Closing the workspace ends the panes hosting the implementer agent; there is **no** separate agent-stop verb. Leave the main `<repo>-<slug>-plan` workspace untouched. Do not hardcode Herdr command syntax; the installed binary is the authority.
3. Report back: merge result, worktree removed and its `<repo>-<slug>-dev` workspace closed, and any non-blocking follow-ups left for later.

## Hard rules

- Never put secrets in review comments, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Never merge before a clean verdict **and** explicit human approval; CI + human review own the merge decision.
- Merge and worktree removal happen only in remote mode, from the repository root — never from inside the worktree, never in local mode.
- Do the review with fresh context (subagent), not the developer's context.

## Definition of Done

- Change reviewed against its acceptance criteria, the repo's checks, and the quality lenses — with fresh context, in the correct mode for where it was launched.
- A clear verdict presented: clean or not clean (findings + next steps).
- Local mode, clean: verdict is "ready — open the PR"; nothing merged or removed.
- Remote mode, clean and approved: PR merged per repo convention, the task's worktree removed and its `<repo>-<slug>-dev` workspace closed — all from the root — and results reported.
- If not clean: findings summarized with next steps; nothing merged or removed.

## Related

If the review surfaces work beyond this PR's scope, suggest running `generating-tickets` to capture it as new tickets. Do not auto-invoke it.
