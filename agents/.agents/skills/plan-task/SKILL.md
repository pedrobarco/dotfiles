---
name: plan-task
description: "Plan one task from a description or ticket ID, then drive it to a PR across two sessions: session 1 (this skill) plans, runs the in-workflow fresh-eyes review, and drafts the PR; session 2 implements. Use when asked to take a single task or ticket from plan to PR, to plan and drive a feature to completion, or as the entry point of the implement/review loop. Not for ranking a backlog (prioritizing-work), drafting tickets (generating-tickets), reviewing someone else's open PR (reviewing-pull-requests, remote mode), or one-off chores. Session 1 is read/reason/git-metadata only — it never writes feature code and never self-merges; only the implementer session edits, and CI plus human review gate the merge."
---

# Plan Task

This is the orchestrator and entry point of the implement/review loop, run as **session 1** of a two-session workflow. Given a task **description or ticket ID**, it cross-checks the task, produces an approved implementation plan, sets up an isolated worktree and workspace, then delegates **only the coding** to a long-lived **session 2** (`implement-task`). Session 1 keeps the plan and acceptance criteria in context and runs the **in-workflow review** (fresh-eyes subagent) and **PR draft** itself, coordinating each hand-off behind a human gate.

*Pipeline position: session-1 orchestrator — delegates coding to session 2 (`implement-task`), runs review (`reviewing-pull-requests`, local mode) and `create-pr` in-session. Standalone (not driven by this skill): `generating-tickets`, `prioritizing-work`, and remote-PR review (`reviewing-pull-requests`, remote mode).*

## Scope

- Plan one task (from a description or a ticket ID) as small, verifiable steps.
- Set up one dedicated worktree and one fresh workspace for the task.
- Run session 1 in order — plan, in-workflow review, PR draft — delegating only the implement phase to session 2, stopping at each human gate.

Never do the following from this skill:

- Write or edit feature code — that happens only in the implementer session (session 1 is read/reason/git-metadata only).
- Merge, or skip the plan-approval gate or any downstream write gate.
- Reuse a workspace across tasks, or run two tasks in one worktree.

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
- Any assumptions, risks, or open questions from the cross-check.

Stop and ask for approval. Do not create the worktree or delegate any work until the human approves the plan. If they request changes, revise and re-present.

## Set up the worktree and workspace

Only after the plan is approved. Worktrees are managed by **worktrunk** (`wt`); herdr **workspaces** are the session unit. The task gets its own worktree *and* its own fresh workspace — never reuse a workspace, and never run two tasks in one worktree.

Only orchestrate from inside Herdr. Follow the `herdr` skill for all Herdr mechanics (verify `HERDR_ENV=1`, workspace/pane/agent commands, reading IDs from JSON, `--no-focus`). Do not hardcode Herdr syntax here; the installed binary is the authority. If not inside Herdr, say so and stop after the approved plan.

1. Derive names. **Branch:** use the repo's prefix convention from `AGENTS.md` when declared (e.g. `feat/`, `fix/`); otherwise `feature/<slug>` for features/refactors/chores or `hotfix/<slug>` for bug fixes. Workspace label `wf-<repo>-<slug>` (`<repo>` = repository name, `<slug>` = short slug from the task).
2. Create the worktree and read back its path (do not `cd` into it):
   ```bash
   wt switch --create <branch> --no-cd
   wt list --format json   # read the worktree .path for <branch>
   ```
3. Create a fresh, dedicated herdr workspace rooted at that worktree path (label `wf-<repo>-<slug>`), per the `herdr` skill. Read the root pane ID from the JSON response.

## Orchestrate the phases

Two sessions per task. **Session 1 is this skill** — it runs plan, review, and PR draft itself, keeping the plan and acceptance criteria in context. **Session 2 is the implementer** — the only session that writes feature code, kept alive across the review fix loop so it retains context when findings come back.

Follow the `herdr` skill for all session/agent mechanics (launch interactively as the model-pinned agent — pass the agent kind and `--pane`; never a print/one-shot flag, never the task after `--`; prompt with `herdr agent prompt <workspace> "<prompt>" --wait`). Pick the model per session from the matrix below.

1. **Delegate implement (session 2).** Launch the implementer agent in the task's workspace and tell it to load `implement-task` and implement the approved plan (include the plan and acceptance criteria). It codes against the plan, runs the repo's build/lint/test, and stops at its own write gate. Keep this session alive for the fix loop.
2. **Review in-session (session 1).** Spawn a **fresh-context subagent** (the `reviewer` kind) to load `reviewing-pull-requests` in **local mode** and review the live worktree diff against the plan. The subagent gives fresh eyes even though it is launched from session 1; it is review-only and never edits. If the verdict is not clean, relay the findings to the session-2 implementer and re-review — loop until clean.
3. **Draft the PR in-session (session 1).** Load `create-pr` and open a draft-first PR for the reviewed change, linked to the ticket. This runs in session 1 (git/gh only — no file writes) and stops before merge.

Surface each phase's result and gate to the human before advancing. Do not merge — CI and human review own the merge decision. Reviewing someone else's open PR is a separate, standalone job (`reviewing-pull-requests`, remote mode) and is not part of this loop.

### Per-session model matrix

Pick the model by target. On **opencode**, each session maps to a role agent pinned in `opencode.json`. On **cursor**, pass the slug per launch (`cursor-agent --model <slug>`, `--mode plan` for planning); cursor uses **Grok + Composer only**.

| Session | Runs | opencode agent (model) | cursor model (slug) |
| --- | --- | --- | --- |
| 1 — reasoning / coordination | plan-task, in-workflow review (subagent), create-pr | `planner` (`augment/claude-opus-4-8-high`); review via `reviewer` (`augment/claude-opus-4-8-medium`) | Grok 4.6 (`grok-4.6`) |
| 2 — implementation | implement-task | `implementer` (`augment/claude-sonnet-4-6`) | Composer 2.5 (`composer-2.5`) |

Review runs in a **different model family than implement** (Opus vs Sonnet on opencode; Grok vs Composer on cursor) — enforced structurally, because the two sessions are two families. Choose the target from repo/user config or the human's instruction; if ambiguous, ask once. Confirm exact cursor slugs with `cursor-agent --list-models` before pinning.

## Hard rules

- Never put secrets in prompts, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Never write feature code from session 1 — coding happens only in the implementer session (session 2).
- Never merge from this skill, and never skip the plan-approval gate or a downstream write gate.
- Never reuse a workspace or share a worktree between tasks.

## Definition of Done

- Task resolved from a description or ticket ID and cross-checked against the project; acceptance criteria confirmed or refined with the human.
- An implementation plan of small verifiable steps presented and approved before any worktree or delegation.
- A worktrunk worktree created on the derived branch and a fresh dedicated herdr workspace (`wf-<repo>-<slug>`) rooted at it.
- Session 2 delegated the implement phase; session 1 ran the in-workflow review (looped until clean) and drafted the PR — each result and gate surfaced to the human.
- Control returned with the PR link. The merge is left to CI + human review.

## Related

- To rank a backlog and pick what to work on, use `prioritizing-work`; to draft tickets from `main`, use `generating-tickets`; to review someone else's open PR as the merge gate, use `reviewing-pull-requests` (remote mode). All are standalone and not driven by this skill.
- Downstream phase skills: `implement-task` (session 2), `create-pr` (session 1); the in-workflow review reuses `reviewing-pull-requests` (local mode).
