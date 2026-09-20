---
name: creating-pull-requests
description: "Open a draft-first pull request for an already-pushed feature branch, linked to its ticket. Use when a change is implemented, verified, and reviewed clean and you need to open its PR. Not for writing feature code, reviewing a change, or merging. Git and the PR tool only — present the draft before creating, and never merge."
---

# Creating Pull Requests

Take a change that is already implemented, verified, reviewed clean, committed, and pushed, and open a **draft-first** pull request linked to its ticket. Use git and the PR tool only — write no feature files — and stop before merge.

## Inputs

- The feature branch name (already pushed).
- The linked ticket (ID/URL + acceptance criteria).
- Verification notes (which checks ran and their results).
- The review verdict (must be clean). If any of these is missing, ask for it.

## Preconditions

Confirm all of these before drafting. If any fails, stop and report it rather than fixing it here:

- A clean review verdict is in hand.
- The work is **committed** on the feature branch with a clean tree (no uncommitted changes, no stray files, no secrets).
- The branch is **pushed** to the remote and **up to date with its base** (not behind).

## Orient

Read the repo's `AGENTS.md` (nearest up-tree wins) for the conventions this step needs: the **PR tool** and its **draft policy**, the **ticketing system** (how to reference the ticket), and the base branch. It wins on mechanical conventions; it does not override this skill's safety gates (draft-first, the PR-approval gate, no secrets). If silent, infer from repo signals (existing PR history, `gh` availability); if still ambiguous, ask once.

Confirm the branch, its base, and the linked ticket. Gather the pushed diff so the PR body reflects what actually shipped. Name the branch as the PR head (e.g. `gh pr create --head <branch>`) rather than assuming the current checkout is the feature branch.

## Draft the PR

Draft without creating. Present the exact **title** and **body** you intend to submit. The body must:

- Describe what changed and why.
- Link the ticket it implements (reference the ticket ID/URL per repo convention).
- Summarize how it was verified (which build/lint/test checks were run and their results, plus any noted environment bypass and its equivalent verification).
- Note the clean review verdict.

## Approval gate

1. Stop and ask for approval of the draft. If the human requests edits, revise and re-present.
2. On approval, create the PR **draft-first** with the repo's declared PR tool (e.g. `gh pr create --draft --head <branch> --title "…" --body "…"`, or the tool `AGENTS.md` declares), using exactly the approved title and body, targeting the correct base, naming the feature branch as the head, and linking the ticket.
3. Report the PR link back.

Do not merge, and do not mark the PR ready-for-review unless the repo's convention (per `AGENTS.md`) says the drafting step should.

## Hard rules

- Never put secrets in the PR title, body, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Never write or commit feature code from this step — git and the PR tool only.
- Never create or edit a PR without explicit approval, and never create the PR before its draft is approved.
- Never merge or push to the default branch.

## Definition of Done

- Preconditions confirmed, or stopped and reported if they were not.
- PR draft (title + body) presented with the ticket link and verification summary, and approved before creation.
- PR opened draft-first with the approved title/body, targeting the correct base and linked to the ticket.
- PR link reported back. Stop there.
