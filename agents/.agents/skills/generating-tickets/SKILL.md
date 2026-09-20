---
name: generating-tickets
description: "Review the current state of a repository's default branch to surface issues, features, refactors, and risks, then draft tickets for approval. Use when triaging a repo, reviewing main or the default branch for new work, turning review findings into tickets, or asking what work a codebase needs. Not for ranking an existing backlog, planning or implementing a ticket, reviewing a pull request, or filing a ticket whose body the human already wrote. Proposes a draft list first and never writes tickets without explicit approval."
---

# Generating Tickets

Assess the current state of the default branch, surface candidate work, and turn findings into a draft ticket list. Propose only: do not implement, and do not write tickets until they are approved.

## Inputs

- A clean checkout of the repository's default branch. If you are not on the default branch or the tree is dirty, stop and say so.

## Orient

Read the repo's `AGENTS.md` (nearest up-tree wins) for the conventions this step needs: the **ticketing system** (this skill is ticketing-agnostic — GitHub Issues, Jira, Linear, etc.; use whatever the repo declares) and the **verify commands** (build/lint/test) you assess against, plus boundaries and any hard rules. It wins on mechanical conventions; it does not override this skill's safety gates (approval before any write, read-only against the codebase, no secrets). If silent, infer from repo signals (ticketing from `.github/ISSUE_TEMPLATE` or repo config, commands from a Makefile/justfile/package scripts); if still ambiguous, ask once.

Skim recent history (`git log`, recent PRs) to understand what changed and what is in flight.

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

- Default branch assessed and review lenses applied.
- A draft ticket list presented for approval.
- On approval: approved tickets created in the configured system, with IDs/links reported back.
- No code changed, no branches or PRs touched.
