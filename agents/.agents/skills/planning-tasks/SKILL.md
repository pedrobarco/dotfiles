---
name: planning-tasks
description: "Produce an approved implementation plan for one task, from a description or ticket ID. Cross-check the task against the codebase, then present small, individually verifiable steps and get approval. Use when asked to plan a task or ticket, or to turn a ticket into an approved plan. Not for writing feature code, opening a PR, ranking a backlog, or drafting tickets. Read/reason only — stop at an approved plan."
---

# Planning Tasks

Given a task **description or ticket ID**, cross-check it against the current codebase and produce an **approved implementation plan** of small, verifiable steps. Plan only: write no feature code, and stop once the plan is approved.

## Inputs

- A ticket ID (load its description and acceptance criteria) or a free-form task description.
- Read access to the codebase. If you cannot read the code you are asked to plan against, stop and say so.
- The repo's default branch, or a stated base. If HEAD is something else, say so and read that base; do not create or switch branches.

If neither a ticket nor a description is clear, ask which task before planning.

## Orient

Read the repo's `AGENTS.md` (nearest up-tree wins) for the conventions this step needs: **ticketing system**, **branch-prefix convention**, and **verify commands** (build/lint/test). It wins on mechanical conventions; it does not override this skill's safety gates (plan approval, no secrets). If silent, infer from repo signals (`git log`, Makefile/justfile/package scripts, issue templates); if still ambiguous, ask once.

## Cross-check the task

Before planning, verify the task holds up against the current state of the project — do not take it at face value.

- Read the code, tests, and docs in the areas the task touches.
- Confirm the described problem/gap actually exists, and that any stated acceptance criteria are correct, complete, and achievable.
- Note anything missed, already-done, wrong, or in conflict with the codebase or `AGENTS.md`.

If the task materially misaligns with reality (wrong, already resolved, too big, or based on a false premise), stop and report what you found. Propose a corrected understanding or refined acceptance criteria for the human to confirm — do not silently reinterpret or expand it.

## Plan

Produce a short implementation plan as a sequence of **small, individually verifiable steps** — each a coherent change that can be built/linted/tested on its own, ordered so the branch stays green.

Summarize for the human:

- The confirmed (or refined) acceptance criteria this plan satisfies.
- The ordered steps, each with a one-line intent and how it will be verified.
- The **branch name** this task will use, per the repo's prefix convention from `AGENTS.md` (else `feature/<slug>` for a feature/refactor/chore or `hotfix/<slug>` for a bug fix, from a short `<slug>` of the task).
- Any assumptions, risks, or open questions from the cross-check.

## Approval gate

Stop and ask for approval. If they request changes, revise and re-present. The approved plan (acceptance criteria, steps, and branch name) is the output. Stop there. Do not start implementation.

## Hard rules

- Never put secrets in prompts, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Never write feature code. Planning is read/reason only.
- Never skip the plan-approval gate.

## Definition of Done

- Task resolved from a description or ticket ID and cross-checked against the project; acceptance criteria confirmed or refined with the human.
- An implementation plan of small, individually verifiable steps presented and **approved**.
- The branch name stated per the repo's convention.
- No feature code written — the approved plan is the deliverable.
