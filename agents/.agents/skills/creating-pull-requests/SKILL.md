---
name: creating-pull-requests
description: "Open a draft-first pull request for a reviewed, already-pushed feature branch, linked to its ticket. Use when a change has been implemented, verified, and reviewed clean and you need to open its PR. Not for planning (planning-tasks), writing or committing feature code (implementing-tasks), reviewing a change (reviewing-pull-requests), or merging. Git/gh only — it writes no feature files, presents the draft before creating, and never merges: CI and human review gate the merge."
---

# Creating Pull Requests

This is the **PR-opening** capability of the agentic SDLC. It takes a change that is already implemented, verified, reviewed clean, committed, and pushed, and opens a **draft-first** pull request linked to its ticket. It uses git and the PR tool only — it writes no feature files — and it stops before merge.

## Run context

- **Role / model:** the **planner** (reasoning) role — on opencode the `planner` agent (`augment/claude-opus-4-8-high`, `edit: deny`); on cursor, Grok. Git and PR-tool metadata only; no file writes.
- **Location:** the task's main `<repo>-<slug>-plan` workspace at the repository root (or its main checkout), **not** inside the feature worktree. Target the feature branch explicitly — recover the worktree path from `wt list --format json` for the branch (`.items[].worktree.path`, matched by `.items[].branch`) and read diffs with `git -C <worktree>`, and name the branch as the PR head (`gh pr create --head <branch>`) rather than assuming the root's checked-out branch.
- **On entry:** confirm the preconditions below and read the repo's `AGENTS.md`. If the branch is not pushed or not reviewed clean, stop — that work belongs to `implementing-tasks` and `reviewing-pull-requests`.

## Scope

- Draft and, on approval, open one pull request for the current feature branch, linked to its ticket.
- Use the repo's declared PR tool and conventions.

Never do the following:

- Write or edit feature code, or commit it — this capability is git/gh only.
- Run a PR-tool operation without the human's explicit approval, or create the PR before its draft is approved.
- Merge the PR or push to the default branch.

## Preconditions

Confirm all of these before drafting. If any fails, hand back to `implementing-tasks` rather than fixing it here:

- The change is **reviewed clean** (the pre-PR review returned a clean verdict).
- The work is **committed** on the feature branch with a clean tree (no uncommitted changes, no stray files, no secrets).
- The branch is **pushed** to the remote and **up to date with its base** (not behind — rebasing + re-verifying belongs to `implementing-tasks`).

## Orient

1. Read the repo's `AGENTS.md` (nearest up-tree wins) for the conventions this stage needs: the **PR tool** and its **draft policy**, the **ticketing system** (how to reference the ticket), and the base branch. Read them by meaning, wherever the repo states them. `AGENTS.md` is the authority for these mechanical conventions and overrides this skill on conflict — but it never overrides the safety gates (draft-first, the PR-approval gate, no self-merge, no secrets). If silent, infer from repo signals (existing PR history, `gh` availability); if still ambiguous, ask once.
2. Confirm the branch, its base, and the linked ticket (ID/URL + acceptance criteria). Gather the pushed diff so the PR body reflects what actually shipped, targeting the feature branch explicitly per the Run context (`git -C <worktree>`).

## Draft the PR

Draft without creating. Present the exact **title** and **body** you intend to submit. The body must:

- Describe what changed and why.
- Link the ticket it implements (reference the ticket ID/URL per repo convention).
- Summarize how it was verified (which build/lint/test checks were run and their results, plus any noted environment bypass and its equivalent verification).
- Note the clean review verdict.

## Gate and create

1. Stop and ask for approval of the draft. If the human requests edits, revise and re-present.
2. On approval, create the PR **draft-first** with the repo's declared PR tool (e.g. `gh pr create --draft --head <branch> --title "…" --body "…"`, or the tool `AGENTS.md` declares), using exactly the approved title and body, targeting the correct base, naming the feature branch as the head (since you are at the repo root, not the worktree), and linking the ticket.
3. Report the PR link back.

Do not merge, and do not mark the PR ready-for-review unless the repo's convention (per `AGENTS.md`) says the drafting step should — the merge decision belongs to CI + human review.

## Hard rules

- Never put secrets in the PR title, body, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Never write or commit feature code from this step — git/gh only.
- Never run a PR-tool operation without explicit approval, and never create the PR before its draft is approved.
- Never merge or push to the default branch; CI + human review own the merge.

## Definition of Done

- Preconditions confirmed (reviewed clean, committed, pushed, up to date with base) or handed back to `implementing-tasks`.
- PR draft (title + body) presented with the ticket link and verification summary, and approved before creation.
- PR opened draft-first with the approved title/body, targeting the correct base and linked to the ticket.
- PR link reported back. The merge is left to CI + human review.

## Related

- The change this opens a PR for is produced by `implementing-tasks` and reviewed clean by `reviewing-pull-requests` (local mode).
- Reviewing the resulting open PR as the merge gate: `reviewing-pull-requests` (remote mode).
