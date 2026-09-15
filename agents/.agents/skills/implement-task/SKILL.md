---
name: implement-task
description: "Implement an already-approved plan on a feature branch inside a dedicated git worktree, verify it against the repo's own checks, then commit and push — the coding session (session 2) of the plan-task loop. Use when dispatched by plan-task with an approved plan and acceptance criteria, or told to implement a plan in an existing worktree. Not for planning a task (plan-task), reviewing a change (reviewing-pull-requests), opening the PR (create-pr), or one-off chores outside a plan. Stays within its worktree/branch; it never reviews its own work, never opens the PR, and never merges."
---

# Implement Task

This is the implementation session (**session 2**) of the `plan-task` loop — the only session that writes feature code. It receives an **already-approved plan** and acceptance criteria, implements them one small step at a time in a dedicated worktree, verifies against the repo's own checks, then commits and pushes the feature branch. It owns its branch only; it never re-plans, never reviews itself, never opens the PR, and never merges.

*Pipeline position: session 2 — dispatched by `plan-task` (session 1); its work is reviewed by `reviewing-pull-requests` (local mode) and shipped by `create-pr`, both in session 1.*

You are dispatched here by `plan-task` with a specific plan. If no plan is given, ask for it before starting — do not invent one (planning is session 1's job).

## Scope

- Implement the approved plan, in this worktree and on this branch.
- Verify using the repository's own checks; add or update tests for the new behavior.
- Commit and push the feature branch using the repo's conventions.
- Stay alive across the review fix loop, applying findings relayed from session 1.

Never do the following:

- Re-plan or expand scope beyond the approved plan. If the plan is wrong or too big, stop and report back to session 1.
- Review or approve your own work as the gate, or open/merge the PR.
- Edit files outside this worktree, or create/remove/switch worktrees — the worktree lifecycle is owned by session 1 / the human.

## Orient

1. Confirm you are in the intended worktree and on the assigned feature branch (per the repo's prefix convention), not the default branch.
2. Read the repo's `AGENTS.md` (nearest up-tree wins) for the conventions this stage needs: **verify commands** (build/lint/test) and **commit conventions**. Read them by meaning, wherever the repo states them. `AGENTS.md` is the authority for these mechanical conventions and overrides this skill on conflict — but it never overrides the safety gates (the change-approval gate, no self-review, no self-merge, no secrets). If silent, infer from repo signals (`git log`, Makefile/justfile/package scripts); if still ambiguous, ask once.
3. Re-read the approved plan and its acceptance criteria — this is exactly what you implement, no more.

## Cross-check the plan

Before coding, confirm the plan still holds against the current state of the code — read the areas each step touches. If a step is already done, wrong, or blocked by something the plan missed, stop and report back to session 1 rather than silently deviating. Session 1 owns the plan; you flag drift, you do not re-plan.

## Implement

Work the approved plan one step at a time, in small coherent increments, keeping the branch green step to step. Follow the existing conventions and structure of the codebase — match the surrounding style; do not restructure unrelated code. Keep the change focused on the approved acceptance criteria. If implementation reveals the plan was wrong, stop, report to session 1, and re-confirm rather than drifting from it.

## Verify

Discover the actual commands from the repo's `AGENTS.md` (or the project's standard tooling — Makefile/justfile target, package scripts, `cargo`/`go`/`pnpm`, etc.). Do not assume; use what the repo declares.

The task is **not complete** until all of the following pass:

- **Build** — the project builds/compiles cleanly.
- **Lint / format** — the linter and formatter pass.
- **Tests** — the test suite passes; add or update tests to cover the new behavior.

Iterate until every check is green. Do not bypass, skip, or disable failing checks; fix the cause or, if genuinely blocked, stop and report why.

Distinguish a check that fails *on your change* (must fix — never bypass) from one that fails because the **local tooling environment is broken** (e.g. a pre-commit hook whose cached linter binary panics on a toolchain mismatch). For the latter, run the underlying tool directly to confirm your change is clean, then proceed and **note the bypass and your equivalent verification** so the reviewer confirms CI is green. Do not silently `--no-verify`.

## Present for review and get approval

Once every check is green, stop and present the completed work before committing. Summarize for the human:

- What changed, grouped by area (files/modules touched and why).
- How each approved acceptance criterion is now satisfied.
- How it was verified (which build/lint/test commands were run and their results).
- Anything notable: trade-offs made, follow-ups deferred, or deviations flagged.

Stop and ask for approval. The human (or session 1) may approve or request changes — make them, re-verify, and re-present. Do not commit until the change itself is approved. The independent fresh-eyes review is run by session 1 (`reviewing-pull-requests`, local mode), not by you.

## Commit, push, and handle the fix loop

- Commit on the feature branch using the repo's commit conventions (read `AGENTS.md`; e.g. conventional commits, issue refs).
- Keep the branch clean: no stray files, no unrelated changes, no committed secrets.
- Rebase onto the current base branch if the branch has fallen behind, then re-run verification.
- Push the branch to the remote so session 1 can open the PR.
- **Stay alive.** When session 1's review relays findings, apply them here, re-verify, re-present, and re-push — you retain the plan and context across the loop. Do not open the PR yourself.

## Hard rules

- Never put secrets in code, commits, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Stay within scope and within this worktree/branch; never create, remove, or switch worktrees.
- Never review or merge your own work, and never open the PR — those are session 1's jobs.
- Never commit before the change is approved, and never bypass a failing check on your own change.

## Definition of Done

- Approved plan cross-checked against the code; drift (if any) reported to session 1 rather than silently reinterpreted.
- Plan implemented against the approved acceptance criteria, one verifiable step at a time.
- Build clean, lint/format passing, tests passing (new behavior covered).
- Completed changes summarized and approved before commit.
- Changes committed on the feature branch (repo conventions), branch clean, rebased on base, and pushed.
- Session kept alive for the review fix loop. The PR is opened by session 1 (`create-pr`); merge is left to CI + human review.

## Related

- Planning and orchestration: `plan-task` (session 1, dispatches this skill).
- Fresh-eyes review of this change before the PR: `reviewing-pull-requests` (local mode), run by session 1 — not by you.
- Opening the PR once the branch is pushed and reviewed: `create-pr` (session 1).
