---
name: planning-tasks
description: "Produce an approved implementation plan for one task, from a description or ticket ID: cross-check it against the codebase, then present small, individually verifiable steps and get approval. Use when asked to plan a task or ticket, or to turn a ticket into an approved plan before implementation. Not for writing code (implementing-tasks), reviewing a change (reviewing-pull-requests), opening a PR (creating-pull-requests), ranking a backlog (prioritizing-work), or drafting tickets (generating-tickets). Read/reason only — it writes no feature code, creates no worktree, and stops at an approved plan."
---

# Planning Tasks

This is the **planning** capability of the agentic SDLC. Given a task **description or ticket ID**, it cross-checks the task against the current codebase and produces an **approved implementation plan** of small, verifiable steps. It plans only: it writes no feature code, creates no worktree, and hands nothing off — once the plan is approved, a human runs the next capability.

## Run context

- **Role / model:** the **planner** (reasoning) role — on opencode the `planner` agent (`augment/claude-opus-4-8-high`, `edit: deny`); on cursor, Grok. Read/reason/git-metadata only.
- **Location:** the task's main `<repo>-<slug>-plan` workspace at the repository root (or, run directly, the repo root / main checkout), reading the default branch. Recover the `<slug>` from the agent name if launched by `prioritizing-work`, else coin it from the ticket/task. No feature worktree is needed — planning reads the code where it already is.
- **On entry:** resolve the task input (below) and read the repo's `AGENTS.md`. If you cannot read the codebase you are asked to plan against, stop and say so.

## Scope

- Plan one task (from a description or a ticket ID) as small, individually verifiable steps.
- Cross-check the task against the codebase before planning.
- Stop at an approved plan.

Never do the following from this skill:

- Write or edit feature code, or create the feature worktree / `<repo>-<slug>-dev` workspace — those belong to `implementing-tasks`.
- Merge, or skip the plan-approval gate.

## Orient

1. Read the repo's `AGENTS.md` (nearest up-tree wins) for the conventions this loop needs: **ticketing system**, **branch-prefix convention**, **verify commands** (build/lint/test), **commit conventions**, and the **PR tool**. Read them by meaning, wherever the repo states them. `AGENTS.md` is the authority for these mechanical conventions and overrides this skill on conflict — but it never overrides the safety gates (plan/write/PR approval, no self-merge, no secrets). If silent, infer from repo signals (`git log`, Makefile/justfile/package scripts, issue templates); if still ambiguous, ask once.
2. Resolve the input. If given a ticket ID, load the ticket (description + acceptance criteria). If given a free-form description, treat it as the task statement. If neither is clear, ask which task before planning.

## Cross-check the task

Before planning, verify the task holds up against the current state of the project — do not take it at face value.

- Read the code, tests, and docs in the areas the task touches.
- Confirm the described problem/gap actually exists, and that any stated acceptance criteria are correct, complete, and achievable.
- Note anything missed, already-done, wrong, or in conflict with the codebase or `AGENTS.md`.

If the task materially misaligns with reality (wrong, already resolved, too big, or based on a false premise), stop and report what you found. Propose a corrected understanding or refined acceptance criteria for the human to confirm — do not silently reinterpret or expand it.

## Plan and get approval

Produce a short implementation plan as a sequence of **small, individually verifiable steps** — each a coherent change that can be built/linted/tested on its own, ordered so the branch stays green.

Summarize for the human:

- The confirmed (or refined) acceptance criteria this plan satisfies.
- The ordered steps, each with a one-line intent and how it will be verified.
- The **branch name** this task will use, per the repo's prefix convention from `AGENTS.md` (else `feature/<slug>` for a feature/refactor/chore or `hotfix/<slug>` for a bug fix, from a short `<slug>` of the task) — so whoever implements it lands on the same branch/worktree.
- Any assumptions, risks, or open questions from the cross-check.

Stop and ask for approval. If they request changes, revise and re-present. The approved plan (with its acceptance criteria and branch name) is the output — a human takes it to `implementing-tasks` from here.

## Hard rules

- Never put secrets in prompts, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Never write feature code or create the feature worktree / dev workspace from this skill — planning is read/reason only.
- Never merge, and never skip the plan-approval gate.

## Definition of Done

- Task resolved from a description or ticket ID and cross-checked against the project; acceptance criteria confirmed or refined with the human.
- An implementation plan of small, individually verifiable steps presented and **approved**.
- The branch name stated per the repo's convention so implementation lands consistently.
- No feature code written and no worktree created — the approved plan is the deliverable.
