---
name: prioritizing-work
description: "Rank an existing backlog by stated priority, value/complexity, effort/risk, and dependencies to recommend the next best candidates, and optionally dispatch a developer into an isolated worktree. Use when deciding what to work on next, prioritizing a backlog, or picking the next ticket. Not for implementing a ticket yourself — even the highest-priority one — which belongs to the developer role; this skill chooses and dispatches, it does not write code. Runs in the repository root and never implements or merges code itself."
---

# Prioritizing Work

This is the planner role of the agentic SDLC. It runs in the repository root, reads the existing backlog, ranks it, and recommends the next best candidates. It can optionally fire-and-forget a developer agent into an isolated worktree for the chosen candidate, then returns immediately — it never waits on, polls, or babysits developers.

*Pipeline position: step 2 of 4 — upstream: `generating-tickets`; downstream: `implementing-features` (via dispatch).*

To generate the backlog in the first place (review main → draft tickets), use `generating-tickets`.

## Scope

- Read the backlog and rank it.
- Recommend the next best candidates with rationale.
- Optionally dispatch one developer per chosen candidate (fire-and-forget).

Never do the following from this skill:

- Write or edit feature code.
- Merge branches or pull requests.
- Wait for, poll, or supervise a dispatched developer.

## Read the backlog

1. Read the repo's `AGENTS.md` (nearest file up-tree wins) for the conventions this stage needs: the **ticketing system** (this skill is ticketing-agnostic — GitHub Issues, Jira, Linear, etc.; use whatever the repo declares) and the **branch-prefix convention** used at dispatch. Read them by meaning, wherever the repo states them — don't require a dedicated block. `AGENTS.md` is the authority for these mechanical conventions; it does not override this skill's safety gates (never merge, fire-and-forget, no secrets). If the repo has no `AGENTS.md` or is silent on a key, infer from repo signals (ticketing from repo config / issue templates, prefix from existing branch names); if still ambiguous, ask once rather than assume.
2. Load open tickets with their stated priority, labels, and any effort/risk/dependency metadata already present.
3. Note dependency links (`blocked-by` / `blocks`) so blocked work can be deferred.

## Prioritization model

Rank candidates using all four axes. Be explicit — show the reasoning, not just an ordering.

- **Stated priority** — the ticket's own priority field/label.
- **Value / complexity** — estimated impact relative to implementation complexity (favor high value, low complexity).
- **Effort / risk** — rough size (S/M/L) and blast radius; prefer lower risk when value is comparable.
- **Dependencies** — skip anything `blocked-by` an open ticket; surface unblockers that would release high-value work.

Output a ranked shortlist (top 3–5) where each entry states: ticket ID/title, the four-axis assessment, and a one-line "why this next" rationale. Call out any high-value work that is currently blocked and what would unblock it.

## Optional dispatch (fire-and-forget)

Only when the human picks a candidate to start. Dispatch fires immediately for the chosen candidate — no extra confirmation — then this skill returns to planning without waiting. "Fire-and-forget" means never waiting for the developer to *finish*: the `agent prompt … --wait` in step 5 only blocks until the developer accepts the work (its first settled lifecycle state), which confirms the task was delivered — it does not poll to completion.

Only dispatch from inside Herdr. Follow the `herdr` skill for all Herdr mechanics — verifying `HERDR_ENV=1`, workspace/pane/agent commands, reading IDs from JSON, and `--no-focus` conventions. Do not hardcode Herdr command syntax here; the installed binary is the authority. If not inside Herdr, say so and stop at recommending.

Worktrees are managed by **worktrunk** (`wt`), the same tool behind the `prefix+shift+t` worktree manager. herdr **workspaces** are the session unit. Each dispatch gets its own worktree *and* its own fresh workspace — never reuse a workspace, since parallel developers must not share a working directory.

1. Derive names. **Branch:** use the repo's branch-prefix convention from `AGENTS.md` when it declares one (e.g. `feat/`, `fix/`); otherwise default to `feature/<feat>` for features/refactors/chores or `hotfix/<bug>` for bug fixes (choose from the ticket's type). A `security` ticket routes by urgency — an urgent fix takes the bug/hotfix prefix, otherwise the feature prefix. Workspace label + agent name `dev-<repo>-<slug>` (`<repo>` = repository name, `<slug>` = short slug from the ticket).
2. Create the worktree with worktrunk and read back its path (do not `cd` into it here):
   ```bash
   wt switch --create <branch> --no-cd
   wt list --format json   # read the worktree .path for <branch>
   ```
3. Create a fresh, dedicated herdr workspace rooted at that worktree path (label `dev-<repo>-<slug>`), per the `herdr` skill. Read the new workspace's root pane ID from the JSON response.
4. Start the developer agent **interactively** in that root pane, per the `herdr` skill — pass only the agent **kind** (from the matrix below) and `--pane`. Do **not** pass the task after `--`, and never a print/one-shot flag (auggie `-p`, claude `-p`, opencode `run`): those launch the agent in non-interactive mode, so Herdr never tracks its lifecycle → false `idle`, frozen state, and `agent prompt`/`agent wait` become unusable. Native args after `--` are only for reattach/config flags, never the task.
5. Deliver the task via `herdr agent prompt dev-<repo>-<slug> "<prompt>" --wait` (per the `herdr` skill). The prompt tells the developer to load `implementing-features` and implement the chosen ticket (include the ticket ID/link and acceptance criteria). `--wait` returns as soon as the developer accepts the work — it confirms delivery, it does not wait for completion.
6. Return immediately. Do not wait for or poll the developer past that acceptance. The developer opens a PR when done; CI and human review gate the merge.

### Provider kind matrix

The `herdr` agent kind is the only provider-specific glue. The task is **always** delivered via `herdr agent prompt` (step 5), never as native launch args — so there is no per-provider prompt syntax to track.

| Provider | herdr kind |
| --- | --- |
| auggie | `auggie` |
| opencode | `opencode` |
| claude | `claude` |

Choose the provider from the repo/user config or the human's instruction. If none declares one, infer from what the repo/environment already uses (e.g. an installed CLI or existing agent config); if still ambiguous, ask once rather than defaulting to a provider.

## Hard rules

- Never put secrets in prompts, commands, or tool arguments. Refer to any discovered secret as redacted.
- After dispatch, do not touch the developer's worktree, branch, or agent.
- Never merge; CI and human review own the merge decision.

## Definition of Done

- A ranked, justified shortlist of next candidates presented (with blocked work called out).
- If a candidate was chosen: a worktrunk worktree created on the derived branch (the repo's `AGENTS.md` prefix convention when declared, else `feature/<feat>` or `hotfix/<bug>`), a fresh dedicated herdr workspace rooted at that worktree path, and a developer agent started interactively in it with the task delivered via `herdr agent prompt … --wait` (per the `herdr` skill, using the kind matrix) — then control returned without waiting for completion.

## Related

If the backlog is empty or thin, suggest running `generating-tickets` to review main and draft new tickets. Do not auto-invoke it.

When a dispatched developer opens its PR, closing the loop is a separate step — review it with fresh context via `reviewing-pull-requests`, which gates the merge and cleans up the worktree. Do not do that from here.
