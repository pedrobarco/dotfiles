---
name: prioritizing-work
description: "Rank an existing backlog by stated priority, value/complexity, effort/risk, and dependencies to recommend the next best candidates, and optionally dispatch a planner to start planning the chosen ticket (plan-task). Use when deciding what to work on next, prioritizing a backlog, or picking the next ticket. Not for implementing a ticket yourself — even the highest-priority one — which belongs to the implement/review capabilities; this skill chooses and dispatches, it does not write code. Runs in the repository root and never implements or merges code itself."
---

# Prioritizing Work

This is the planner/dispatch capability of the agentic SDLC. It reads the existing backlog, ranks it, and recommends the next best candidates. It can optionally fire-and-forget a planner agent that starts `plan-task` for the chosen candidate, then returns immediately — it never waits on, polls, or babysits that work. This is one of two capabilities that may launch another (the other is `implement-task`'s hand-off to local review); every other capability is run directly by a human.

## Run context

- **Role / model:** the **planner** (reasoning) role — on opencode the `planner` agent (`augment/claude-opus-4-8-high`, `edit: deny`); on cursor, Grok. Read/reason only; the only write is launching a planner agent (below).
- **Location:** the repository root. Dispatch runs from inside Herdr and launches the planner into the task's `<repo>-<slug>-plan` session; if not inside Herdr, stop at recommending.
- **On entry:** read the repo's `AGENTS.md` (ticketing system) and load the backlog.

To generate the backlog in the first place (review main → draft tickets), use `generating-tickets`.

## Scope

- Read the backlog and rank it.
- Recommend the next best candidates with rationale.
- Optionally dispatch one planner per chosen candidate (fire-and-forget).

Never do the following from this skill:

- Write or edit feature code.
- Create the feature worktree or `<repo>-<slug>-dev` workspace — `implement-task` owns that.
- Merge branches or pull requests.
- Wait for, poll, or supervise a dispatched planner loop.

## Read the backlog

1. Read the repo's `AGENTS.md` (nearest file up-tree wins) for the conventions this stage needs: the **ticketing system** (this skill is ticketing-agnostic — GitHub Issues, Jira, Linear, etc.; use whatever the repo declares). Read it by meaning, wherever the repo states it — don't require a dedicated block. `AGENTS.md` is the authority for these mechanical conventions; it does not override this skill's safety gates (never merge, fire-and-forget, no secrets). Branch-prefix conventions are resolved later by `plan-task` at plan-approval time, not here. If the repo has no `AGENTS.md` or is silent on the ticketing system, infer from repo signals (repo config / issue templates); if still ambiguous, ask once rather than assume.
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

Only when the human picks a candidate to start. Dispatch fires immediately for the chosen candidate — no extra confirmation — then this skill returns to planning without waiting. "Fire-and-forget" means never waiting for the dispatched work to *finish*: the `agent prompt … --wait` in step 3 only blocks until the planner accepts the work (its first settled lifecycle state), which confirms the ticket was delivered — it does not poll to completion.

Only dispatch from inside Herdr. Follow the `herdr` skill for all Herdr mechanics — verifying `HERDR_ENV=1`, workspace/pane/agent commands, reading IDs from JSON, and `--no-focus` conventions. Do not hardcode Herdr command syntax here; the installed binary is the authority. If not inside Herdr, say so and stop at recommending.

Dispatch here does **not** create a worktree or a dev workspace — that lifecycle belongs to `implement-task`, run later by a human. This step only launches a planner into the task's `<repo>-<slug>-plan` session and hands it the ticket to plan.

1. Derive a short `<slug>` from the ticket and the planner session/agent name `<repo>-<slug>-plan` (`<repo>` = repository name). This is the **single slug for the whole task**: `plan-task` recovers it from this agent name and names the branch from it, and the worktree, dev session/workspace `<repo>-<slug>-dev`, and implementer/reviewer agents (`<repo>-<slug>-dev`, `<repo>-<slug>-review`) all reuse it — so coin it once here. Do **not** derive a branch here — `plan-task` states it at plan-approval time.
2. Start the planner agent **interactively** in the task's `<repo>-<slug>-plan` session at the repository root, per the `herdr` skill — pass only the agent **kind** (from the matrix below) and `--pane`. Do **not** pass the task after `--`, and never a print/one-shot flag (auggie `-p`, claude `-p`, opencode `run`): those launch the agent in non-interactive mode, so Herdr never tracks its lifecycle → false `idle`, frozen state, and `agent prompt`/`agent wait` become unusable. Native args after `--` are only for reattach/config flags, never the task.
3. Deliver the ticket via `herdr agent prompt <repo>-<slug>-plan "<prompt>" --wait` (per the `herdr` skill). The prompt tells the planner to load `plan-task`, reuse the `<slug>` from its own agent name, and produce an approved plan for the chosen ticket (include the ticket ID/link and acceptance criteria). `plan-task` states the branch and stops at the approved plan; implementation is a later, human-run step. `--wait` returns as soon as the planner accepts the work — it confirms delivery, it does not wait for completion.
4. Return immediately. Do not wait for or poll past that acceptance. The planner produces an approved plan; a human carries it forward from there.

### Provider kind matrix

The `herdr` agent kind is the only provider-specific glue. The task is **always** delivered via `herdr agent prompt` (step 3), never as native launch args — so there is no per-provider prompt syntax to track.

| Provider | herdr kind |
| --- | --- |
| auggie | `auggie` |
| opencode | `opencode` |
| claude | `claude` |
| cursor | `cursor` |

Choose the provider from the repo/user config or the human's instruction. If none declares one, infer from what the repo/environment already uses (e.g. an installed CLI or existing agent config); if still ambiguous, ask once rather than defaulting to a provider.

## Hard rules

- Never put secrets in prompts, commands, or tool arguments. Refer to any discovered secret as redacted.
- After dispatch, do not touch the planner loop's worktree, branch, or agent.
- Never merge; CI and human review own the merge decision.

## Definition of Done

- A ranked, justified shortlist of next candidates presented (with blocked work called out).
- If a candidate was chosen: a planner started interactively in the task's `<repo>-<slug>-plan` session at the repository root, with the ticket delivered via `herdr agent prompt … --wait` (per the `herdr` skill, using the kind matrix) — then control returned without waiting for completion.

## Related

If the backlog is empty or thin, suggest running `generating-tickets` to review main and draft new tickets. Do not auto-invoke it.

Once dispatched, the planner produces an approved plan; a human then runs `implement-task`, `reviewing-pull-requests` (local), and `create-pr`. Gating the merge is a separate step — `reviewing-pull-requests` (remote mode) — done by a human, not from here.
