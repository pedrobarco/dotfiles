---
name: reviewing-pull-requests
description: "Judge whether a completed change is ready to land: evaluate a PR or feature branch against its acceptance criteria, CI/checks, and code quality, then reach a verdict. Use when you need a fresh-eyes review of finished work, a pre-PR check, or a decision on whether a change is mergeable. Not for merging, summarizing a PR, debugging CI, or rebasing. This skill decides readiness; it does not perform those actions."
---

# Reviewing Pull Requests

Look at a change with fresh eyes, measure it against its acceptance criteria and the repo's checks, and reach a **clean** or **not clean** verdict. It is a gate, not a rubber stamp. Do not edit the author's code, and do not merge.

## Inputs

- A change reference: a feature branch, or an open PR.
- The ticket (ID/link + acceptance criteria) the change is supposed to satisfy.

If the change reference or the ticket/acceptance criteria is missing, ask for it. Do not review against implied acceptance criteria.

If you wrote the change under review, stop and say so — do not review your own work.

## Orient

Read the repo's `AGENTS.md` (nearest up-tree wins) for the conventions this step needs: **verify commands** (build/lint/test), the **PR tool**, and the **ticketing system**. It wins on mechanical conventions; it does not override this skill's safety gates (verdict only, no secrets). If silent, infer from repo signals (commands from a Makefile/justfile/package scripts, PR tool from history); if still ambiguous, ask once.

- **Open PR:** read it through the repo's PR tool (`gh pr view`, `gh pr diff`, `gh pr checks`, or the tool `AGENTS.md` declares).
- **Branch:** read the diff against the base branch from the current checkout (or the given branch), and run the repo's verify commands if you can.

Start from only the change reference and the ticket. Form your own conclusions.

## Review

Gate first (cheap, objective), then quality. Stop early if a gate fails.

### Gates

- **Acceptance criteria** — every criterion in the ticket is actually met by the diff, not merely claimed.
- **Checks / CI** — the repo's own checks pass. On an open PR, confirm via the PR tool (`gh pr checks`, or the declared tooling). On a branch, run the repo's verify commands. Do not treat a passing self-report as proof; confirm.

If a gate fails, stop the deep pass — the change is not clean regardless of code quality.

### Quality lenses (applied to the diff)

Pass over the **changed lines** through each lens. Record concrete, located findings (file/line + why it matters), not vague impressions.

- **Correctness** — bugs, unhandled cases, broken invariants, flaky or missing tests for the new behavior.
- **Tech debt** — duplication, dead code, tangled modules, TODO/FIXME left behind.
- **Gaps** — incomplete flows, undocumented behavior, absent error handling introduced by the change.
- **Security** — exposed secrets, unsafe input handling, permission or auth gaps in the diff.
- **DX / maintainability** — unclear structure, weak or missing tests, conventions broken versus the surrounding code.

Classify each finding as **blocking** (must fix before merge) or **non-blocking** (nice-to-have / follow-up).

## Verdict

Present the verdict to the human. Two outcomes:

**Clean** — gates pass and there are no blocking findings. Summarize what was reviewed and why it's ready, and list any non-blocking follow-ups.

**Not clean** — a gate failed or there are blocking findings. Summarize the findings (grouped, located, blocking vs non-blocking).

Stop after presenting the verdict.

## Approval gate

None. This role does not write.

## Hard rules

- Never put secrets in review comments, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Never merge.
- Never rewrite the author's code. Report findings; let the author or a follow-up ticket address them.

## Definition of Done

- Change reviewed against its acceptance criteria, the repo's checks, and the quality lenses.
- A clear verdict presented: clean or not clean, with located findings classified blocking vs non-blocking.
- No merge, no checkout edits, no comments posted unless the human asked.
