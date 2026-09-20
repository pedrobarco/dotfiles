---
name: prioritizing-work
description: "Rank an existing backlog by stated priority, value/complexity, effort/risk, and dependencies to recommend the next best candidates. Use when deciding what to work on next, prioritizing a backlog, or picking the next ticket. Not for implementing a ticket, drafting new tickets, or writing an implementation plan. This skill ranks; it does not write code."
---

# Prioritizing Work

Read the existing backlog, rank it, and recommend the next best candidates. Stop at the shortlist.

## Inputs

- An existing backlog of open tickets (with whatever priority, labels, effort/risk, and dependency metadata they already have).

If the backlog is empty or cannot be loaded, say so and stop. Do not invent tickets.

## Orient

Read the repo's `AGENTS.md` (nearest up-tree wins) for the conventions this step needs: the **ticketing system** (this skill is ticketing-agnostic — GitHub Issues, Jira, Linear, etc.; use whatever the repo declares). It wins on mechanical conventions; it does not override this skill's safety gates (no secrets, ticketing stays read-only). If silent, infer from repo signals (repo config / issue templates); if still ambiguous, ask once.

## Read the backlog

1. Load open tickets with their stated priority, labels, and any effort/risk/dependency metadata already present.
2. Note dependency links (`blocked-by` / `blocks`) so blocked work can be deferred.

## Prioritization model

Rank candidates using all four axes. Be explicit — show the reasoning, not just an ordering.

- **Stated priority** — the ticket's own priority field/label.
- **Value / complexity** — estimated impact relative to implementation complexity (favor high value, low complexity).
- **Effort / risk** — rough size (S/M/L) and blast radius; prefer lower risk when value is comparable.
- **Dependencies** — skip anything `blocked-by` an open ticket; surface unblockers that would release high-value work.

Output a ranked shortlist (top 3–5) where each entry states: ticket ID/title, the four-axis assessment, and a one-line "why this next" rationale. Call out any high-value work that is currently blocked and what would unblock it.

Stop after presenting the shortlist.

## Approval gate

None. This role does not write.

## Hard rules

- Never put secrets in prompts, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Stay read-only on the ticketing system; do not create, edit, close, label, or assign tickets.
- Never write or edit feature code.
- Stop at the shortlist. Do not start other work.

## Definition of Done

- A ranked, justified shortlist of next candidates presented (with blocked work called out).
- No tickets created or modified.
