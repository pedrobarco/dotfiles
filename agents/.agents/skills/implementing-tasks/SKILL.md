---
name: implementing-tasks
description: "Implement an already-approved plan on the current feature branch, verify it against the repo's own checks, then commit and push. Use when you have an approved plan and acceptance criteria to build, or review findings to apply on this branch. Not for writing a plan, reviewing the change as the gate, opening a PR, or ad-hoc coding with no approved plan. Writes feature code only; never reviews its own work as the gate, never opens a PR, and never merges."
---

# Implementing Tasks

Receive an **already-approved plan** and acceptance criteria, or a **findings list** on this branch. Implement one small step at a time on the current feature branch, verify against the repo's own checks, then commit and push. Own the branch only: do not re-plan, do not review your own work as the gate, do not open a PR, and do not merge.

## Inputs

One of:

- An approved plan with acceptance criteria and a branch name.
- A findings list to apply on the current branch.

This session is already on that feature branch. If the current branch does not match the plan (or the findings' branch), stop and say so.

If neither a plan nor findings are given, ask — do not invent a plan.

## Orient

Read the repo's `AGENTS.md` (nearest up-tree wins) for the conventions this step needs: **verify commands** (build/lint/test) and **commit conventions**. It wins on mechanical conventions; it does not override this skill's safety gates (the change-approval gate, no self-review, no self-merge, no secrets). If silent, infer from repo signals (`git log`, Makefile/justfile/package scripts); if still ambiguous, ask once.

If implementing a plan, re-read it and its acceptance criteria — this is exactly what you implement, no more. If applying findings, treat those findings as the scope.

## Cross-check

Before coding, confirm the plan or findings still hold against the current state of the code — read the areas each step touches. If a step is already done, wrong, or blocked by something missed, stop and report it rather than silently deviating. Flag drift; do not re-plan.

## Implement

Work one step at a time, in small coherent increments, keeping the branch green step to step. Follow the existing conventions and structure of the codebase — match the surrounding style; do not restructure unrelated code. Keep the change focused on the approved acceptance criteria or the given findings. If implementation reveals the plan was wrong, stop, report it, and re-confirm rather than drifting from it.

## Verify

Discover the actual commands from the repo's `AGENTS.md` (or the project's standard tooling — Makefile/justfile target, package scripts, `cargo`/`go`/`pnpm`, etc.). Do not assume; use what the repo declares.

The task is **not complete** until all of the following pass:

- **Build** — the project builds/compiles cleanly.
- **Lint / format** — the linter and formatter pass.
- **Tests** — the test suite passes; add or update tests to cover the new behavior.

Iterate until every check is green. Do not bypass, skip, or disable failing checks; fix the cause or, if genuinely blocked, stop and report why.

Distinguish a check that fails *on your change* (must fix — never bypass) from one that fails because the **local tooling environment is broken** (e.g. a pre-commit hook whose cached linter binary panics on a toolchain mismatch). For the latter, run the underlying tool directly to confirm your change is clean, then proceed and **note the bypass and your equivalent verification**. Do not silently `--no-verify`.

## Approval gate

Once every check is green, stop and present the completed work before committing. Summarize for the human:

- What changed, grouped by area (files/modules touched and why).
- How each approved acceptance criterion (or finding) is now satisfied.
- How it was verified (which build/lint/test commands were run and their results).
- Anything notable: trade-offs made, follow-ups deferred, or deviations flagged.

Stop and ask for approval. The human may approve or request changes — make them, re-verify, and re-present. Do not commit until the change itself is approved.

## Commit and push

- Commit on the feature branch using the repo's commit conventions (read `AGENTS.md`; e.g. conventional commits, issue refs).
- Keep the branch clean: no stray files, no unrelated changes, no committed secrets.
- Rebase onto the current base branch if the branch has fallen behind, then re-run verification.
- Push the branch to the remote.
- Do not open a PR.

## Hard rules

- Never put secrets in code, commits, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Stay on the current branch.
- Never review or merge your own work, and never open a PR.
- Never commit before the change is approved, and never bypass a failing check on your own change.

## Definition of Done

- Plan or findings cross-checked against the code; drift (if any) reported rather than silently reinterpreted.
- Scope implemented (approved acceptance criteria, or the given findings), one verifiable step at a time.
- Build clean, lint/format passing, tests passing (new behavior covered).
- Completed changes summarized and approved before commit.
- Changes committed on the feature branch (repo conventions), branch clean, rebased on base, and pushed.
