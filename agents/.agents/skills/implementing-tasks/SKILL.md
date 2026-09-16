---
name: implementing-tasks
description: "Implement an already-approved plan on a feature branch inside a dedicated git worktree, verify it against the repo's own checks, then commit and push. Use when you have an approved plan and acceptance criteria to build, or are told to implement a plan in its feature worktree. Not for planning a task (planning-tasks), reviewing a change (reviewing-pull-requests), opening the PR (creating-pull-requests), or one-off chores outside a plan. Writes code only within its own worktree/branch; it never reviews its own work as the gate, never opens the PR, and never merges. Once its branch is pushed it may auto-launch the separate local reviewer role and relay the verdict, but only when the task's main `<repo>-<slug>-plan` workspace is live to route it to."
---

# Implementing Tasks

This is the **implementation** capability of the agentic SDLC — the one that writes feature code. It receives an **already-approved plan** and acceptance criteria, implements them one small step at a time in a dedicated worktree, verifies against the repo's own checks, then commits and pushes the feature branch. It owns its branch only: it never re-plans, never reviews its own work as the gate, never opens the PR, and never merges.

If no approved plan is given, ask for it before starting — do not invent one (planning is a separate capability, `planning-tasks`).

## Run context

- **Role / model:** the **implementer** role — on opencode the `implementer` agent (`augment/claude-sonnet-4-6`); on cursor, Composer. This is the only role that writes feature code.
- **Location:** the task's `<repo>-<slug>-dev` workspace — the herdr workspace rooted at the task's dedicated feature worktree, on its feature branch. One worktree and one fresh workspace per task — never reuse a workspace or share a worktree between tasks.
- **On entry — find or create the worktree/workspace.** Derive the branch and `<slug>` from the approved plan (branch per the repo's prefix convention, else `feature/<slug>`/`hotfix/<slug>`; `<repo>` = repository name). If you were launched into the worktree/workspace already, confirm you are in them and on the feature branch. Otherwise create them per this convention:

  | Entity | Name |
  | --- | --- |
  | branch | the repo's branch naming convention (prefix from `AGENTS.md` when declared; else `feature/<slug>` or `hotfix/<slug>`) |
  | worktree | the task's `<slug>` (its directory; `wt` computes the path) |
  | dev workspace | `<repo>-<slug>-dev` |
  | implementer agent (this one) | `<repo>-<slug>-dev` |

  Create them the way the enabled **worktrunk** herdr plugin does in workspace mode, but non-interactively — the plugin is an fzf picker for humans (`herdr plugin action invoke open --plugin worktrunk`), so drive its two underlying commands directly here:
  1. `wt switch --create <branch> --no-cd --format=json` on the convention-named branch (add `--base <ref>` to branch off a non-default base) — worktrunk creates the worktree (its directory keyed off the `<slug>`) and runs its setup hooks; read the real worktree path from the returned `.path`.
  2. `herdr worktree open --path <path> --label <repo>-<slug>-dev --no-focus --json` — register that checkout as the nested `<repo>-<slug>-dev` workspace (herdr resolves the repo's root workspace from the path); read its workspace id from the JSON.

  Follow the `herdr` skill for all Herdr mechanics (verify `HERDR_ENV=1`, `--no-focus`, reading IDs from JSON) and worktrunk (`wt`) for the worktree — do not hardcode their syntax; the installed binaries are the authority.
- Then read the repo's `AGENTS.md` and re-read the approved plan.

## Scope

- Implement the approved plan, in this task's worktree and on its feature branch.
- Verify using the repository's own checks; add or update tests for the new behavior.
- Commit and push the feature branch using the repo's conventions.
- Once pushed, launch the separate local reviewer role (fresh context) in the task's `<repo>-<slug>-plan` workspace and relay its verdict — but only when that main workspace is live to route it to; otherwise stop and report the branch is ready for local review.
- If review findings come back on this branch, apply them here, re-verify, and re-push.

Never do the following:

- Re-plan or expand scope beyond the approved plan. If the plan is wrong or too big, stop and report it rather than silently deviating.
- Review or approve your own work as the gate, or open/merge the PR.
- Work in another task's worktree, or remove any worktree — this capability creates or enters only its own task's worktree.

## Orient

1. Read the repo's `AGENTS.md` (nearest up-tree wins) for the conventions this stage needs: **verify commands** (build/lint/test) and **commit conventions**. Read them by meaning, wherever the repo states them. `AGENTS.md` is the authority for these mechanical conventions and overrides this skill on conflict — but it never overrides the safety gates (the change-approval gate, no self-review, no self-merge, no secrets). If silent, infer from repo signals (`git log`, Makefile/justfile/package scripts); if still ambiguous, ask once.
2. Re-read the approved plan and its acceptance criteria — this is exactly what you implement, no more.

## Cross-check the plan

Before coding, confirm the plan still holds against the current state of the code — read the areas each step touches. If a step is already done, wrong, or blocked by something the plan missed, stop and report it rather than silently deviating. The plan is owned by the planner (`planning-tasks`); you flag drift, you do not re-plan.

## Implement

Work the approved plan one step at a time, in small coherent increments, keeping the branch green step to step. Follow the existing conventions and structure of the codebase — match the surrounding style; do not restructure unrelated code. Keep the change focused on the approved acceptance criteria. If implementation reveals the plan was wrong, stop, report it, and re-confirm rather than drifting from it.

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

Stop and ask for approval. The human may approve or request changes — make them, re-verify, and re-present. Do not commit until the change itself is approved. The independent fresh-eyes review is a separate capability (`reviewing-pull-requests`, local mode) run by a different role — not by you.

## Commit, push, and handle review findings

- Commit on the feature branch using the repo's commit conventions (read `AGENTS.md`; e.g. conventional commits, issue refs).
- Keep the branch clean: no stray files, no unrelated changes, no committed secrets.
- Rebase onto the current base branch if the branch has fallen behind, then re-run verification.
- Push the branch to the remote so the PR can be opened (`creating-pull-requests`).
- **If review findings come back** on this branch, apply them in this same worktree, re-verify, re-present, and re-push. Do not open the PR yourself.

## Hand off to local review

Once the branch is pushed, the change is ready for its fresh-eyes pre-PR review (`reviewing-pull-requests`, local mode) — a check by a **separate reviewer role**, not a gate. Because it is not a gate, you may launch it **without asking** — but only when the task's main `<repo>-<slug>-plan` workspace is live to route the verdict to.

- **The main `<repo>-<slug>-plan` workspace is live** (you are inside Herdr and the task's `<repo>-<slug>-plan` planner workspace is still running): launch the review there. Per the `herdr` skill, start the reserved reviewer agent `<repo>-<slug>-review` in the **reviewer** role (fresh context, `edit: deny` — distinct from you) in that `-plan` workspace; it reads this branch's diff on disk via `git -C <worktree>`. Prompt it to load `reviewing-pull-requests` (local mode) and review this branch's diff against its base and the acceptance criteria; `--wait` for its verdict, then route that verdict to the `-plan` workspace and report it.
  - **Clean:** report "ready — open the PR"; a human runs `creating-pull-requests` next. Do not open the PR yourself.
  - **Not clean:** apply the blocking findings in this same worktree, re-verify, re-present for approval, re-push, and re-run the review.
- **The main `<repo>-<slug>-plan` workspace is not reachable** (not inside Herdr, or it has ended): launch nothing. Stop and report that the branch is pushed and ready for local review, so a human can run `reviewing-pull-requests` (local mode).

You never perform the review yourself — you only launch the separate reviewer role and relay its verdict. Follow the `herdr` skill for all Herdr mechanics (verify `HERDR_ENV=1`, `--no-focus`, reading IDs/state from JSON, discovering the live `-plan` workspace); do not hardcode Herdr syntax.

## Hard rules

- Never put secrets in code, commits, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Stay within scope and within your own task's worktree/branch; never work in or remove another task's worktree.
- Never review or merge your own work, and never open the PR — those are separate roles.
- Never commit before the change is approved, and never bypass a failing check on your own change.

## Definition of Done

- Approved plan cross-checked against the code; drift (if any) reported rather than silently reinterpreted.
- Plan implemented against the approved acceptance criteria, one verifiable step at a time.
- Build clean, lint/format passing, tests passing (new behavior covered).
- Completed changes summarized and approved before commit.
- Changes committed on the feature branch (repo conventions), branch clean, rebased on base, and pushed.
- Local review handed off: when the main `<repo>-<slug>-plan` workspace is live, the separate `reviewer` role was launched there against the pushed diff and its verdict routed there; otherwise stopped and reported the branch ready for local review.
- Review findings, if any, handled in the same worktree. The PR is opened separately (`creating-pull-requests`); merge is left to CI + human review.

## Related

- The approved plan this implements comes from `planning-tasks`.
- Fresh-eyes review of this change before the PR: `reviewing-pull-requests` (local mode), run by a separate reviewer role — which you auto-launch in the `<repo>-<slug>-plan` workspace when it is live, else a human runs it.
- Opening the PR once the branch is pushed and reviewed clean: `creating-pull-requests`.
