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

1. Read the repo's `AGENTS.md` for the ticketing system and conventions. This skill is ticketing-agnostic — use whatever the repo declares (GitHub Issues, Jira, Linear, etc.).
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

Only when the human picks a candidate to start. Dispatch fires immediately for the chosen candidate — no extra confirmation — then this skill returns to planning without waiting.

Only dispatch from inside Herdr. Follow the `herdr` skill for all Herdr mechanics — verifying `HERDR_ENV=1`, workspace/pane/agent commands, reading IDs from JSON, and `--no-focus` conventions. Do not hardcode Herdr command syntax here; the installed binary is the authority. If not inside Herdr, say so and stop at recommending.

Worktrees are managed by **worktrunk** (`wt`), the same tool behind the `prefix+shift+t` worktree manager. herdr **workspaces** are the session unit. Each dispatch gets its own worktree *and* its own fresh workspace — never reuse a workspace, since parallel developers must not share a working directory.

1. Derive names: branch `feature/<feat>` for features/refactors/chores or `hotfix/<bug>` for bug fixes (choose from the ticket's type); workspace label + agent name `dev-<repo>-<slug>` (`<repo>` = repository name, `<slug>` = short slug from the ticket).
2. Create the worktree with worktrunk and read back its path (do not `cd` into it here):
   ```bash
   wt switch --create <branch> --no-cd
   wt list --format json   # read the worktree .path for <branch>
   ```
3. Create a fresh, focused herdr workspace rooted at that worktree path (label `dev-<repo>-<slug>`), per the `herdr` skill. Read the new workspace's root pane ID from the JSON response.
4. Start a developer agent named `dev-<repo>-<slug>` in that root pane, per the `herdr` skill — using the agent **kind** and native **prompt args** from the provider matrix below (native args go after `--`).
5. The one-shot prompt tells the developer to load `implementing-features` and implement the chosen ticket (include the ticket ID/link and acceptance criteria).
6. Return immediately. Do not wait for or poll the developer. The developer opens a PR when done; CI and human review gate the merge.

### Provider launch matrix

The `herdr` agent kind and the native prompt args (passed after `--`) are the only provider-specific glue. Everything else is identical, and the Herdr invocation itself comes from the `herdr` skill.

| Provider | herdr kind | Native prompt args (after `--`) |
| --- | --- | --- |
| auggie | `auggie` | `-p "<prompt>"` (`--continue` / `--resume` to reattach; `--queue` for follow-ups) |
| opencode | `opencode` | `run "<prompt>"` |
| claude | `claude` | `-p "<prompt>"` |

Choose the provider from the repo/user config or the human's instruction.

## Hard rules

- Never put secrets in prompts, commands, or tool arguments. Refer to any discovered secret as redacted.
- After dispatch, do not touch the developer's worktree, branch, or agent.
- Never merge; CI and human review own the merge decision.

## Definition of Done

- A ranked, justified shortlist of next candidates presented (with blocked work called out).
- If a candidate was chosen: a worktrunk worktree created for `feature/<feat>` or `hotfix/<bug>`, a fresh focused herdr workspace rooted at that worktree path, and a developer agent started in it (per the `herdr` skill, using the provider matrix) — then control returned without waiting.

## Related

If the backlog is empty or thin, suggest running `generating-tickets` to review main and draft new tickets. Do not auto-invoke it.

When a dispatched developer opens its PR, closing the loop is a separate step — review it with fresh context via `reviewing-pull-requests`, which gates the merge and cleans up the worktree. Do not do that from here.
