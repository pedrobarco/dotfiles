---
name: generating-tickets
description: "Review the current state of a repository's main branch to surface issues, features, refactors, and risks, then draft tickets for approval. Use when triaging a repo, reviewing main for new work, turning review findings into tickets, or asking what work a codebase needs. Proposes a draft list first and never writes tickets without explicit approval."
---

# Generating Tickets

This is the reviewer role of the agentic SDLC. It runs in the repository root, assesses the current state of `main`, surfaces candidate work, and turns findings into a draft ticket list. It is a proposer, not an implementer and not a merger.

Run this when you want to know what work a repo needs next, or to convert a review pass into tickets. To rank existing tickets and pick what to tackle, use `prioritizing-work` instead.

## Scope

- Review the main branch and propose work.
- Draft tickets and present them for approval.
- Write tickets to the configured system **only after explicit approval**.

Never do the following from this skill:

- Write or edit feature code.
- Create, close, or merge branches or pull requests.
- Create or modify tickets before approval is given.

## Assess main

Establish the current state before proposing anything.

1. Confirm you are on the repository's main/default branch and the working tree is clean.
2. Read the repo's `AGENTS.md` (and any nested ones) for build/test commands, boundaries, and conventions.
3. Skim recent history (`git log`, recent PRs) to understand what changed and what is in flight.
4. Note the ticketing system in use from repo config or `AGENTS.md` — this skill is ticketing-agnostic (GitHub Issues, Jira, Linear, etc.). Do not assume a tool; use whatever the repo declares.

## Review lenses

Pass over the codebase through each lens. Record concrete, located findings (file/area + why it matters), not vague impressions.

- **Correctness** — bugs, unhandled cases, broken invariants, flaky or missing tests.
- **Tech debt** — duplication, dead code, tangled modules, TODO/FIXME clusters, outdated deps.
- **Gaps** — missing features, incomplete flows, undocumented behavior, absent error handling.
- **Security** — exposed secrets, unsafe input handling, permission or auth gaps.
- **DX / maintainability** — missing or slow tooling, unclear structure, weak CI.

A finding is only worth a ticket if a reasonable maintainer would act on it. Drop noise.

## Draft ticket format

For each finding worth acting on, draft a ticket with:

- **Title** — imperative and specific (e.g. `Fix race in pane focus handler`).
- **Context** — what's wrong / missing and where (file or area).
- **Acceptance criteria** — how to know it's done, as a checklist.
- **Rough effort** — S / M / L.
- **Rough risk** — low / medium / high (blast radius, shared surfaces touched).
- **Type/label** — bug / feature / refactor / chore / security.

Keep tickets small and single-purpose. If a finding implies many unrelated changes, split it into several tickets.

## Approval gate

Always present the full draft list first and stop for approval. Do not write anything to the ticketing system until the human approves.

1. Present the drafts as a numbered list (title + one-line summary + effort/risk).
2. Ask which to create, edit, or drop.
3. On approval, create the approved tickets in the configured system, preserving titles, context, acceptance criteria, and labels.
4. Report back the created ticket IDs/links.

If approval is not given, leave the drafts as a pending proposal and take no write action.

## Hard rules

- Never put secrets in ticket bodies, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Never write to the ticketing system before approval.
- Stay read-only against the codebase; this skill does not modify files.

## Definition of Done

- Main branch assessed and review lenses applied.
- A draft ticket list presented for approval.
- On approval: approved tickets created in the configured system, with IDs/links reported back.
- No code changed, no branches or PRs touched.

## Related

When the backlog looks thin or you want to decide what to tackle next, suggest running `prioritizing-work`. Do not auto-invoke it.
