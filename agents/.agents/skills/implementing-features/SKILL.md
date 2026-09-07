---
name: implementing-features
description: "Implement one scoped ticket or feature end-to-end inside an isolated git worktree, verify it against the repo's own checks, and open a pull request. Use when dispatched into a feature worktree, asked to implement a single ticket or feature end-to-end, or told to take a ticket to a PR. Not for one-off chores outside a ticket (dependency bumps, rebases, conflict resolution) or for choosing which ticket to do. Stays within its worktree/branch and never self-merges — CI and human review gate the merge."
---

# Implementing Features

This is the developer role of the agentic SDLC. It runs inside a single git worktree, implements exactly one ticket, verifies it, and opens a pull request. It owns its branch only; it never merges, never reviews itself, and never touches other worktrees or `main`.

*Pipeline position: step 3 of 4 — upstream: `prioritizing-work`; downstream: `reviewing-pull-requests`.*

You are typically dispatched here by `prioritizing-work` with a specific ticket. If no ticket is given, ask which one before starting.

## Scope

- Implement only the assigned ticket, in this worktree and on this branch.
- Verify using the repository's own checks.
- Open a pull request linked to the ticket.

Never do the following:

- Merge the PR or push to `main`/the default branch.
- Review or approve your own work as the gate.
- Edit files outside this worktree, or create nested worktrees. The worktree's lifecycle (creation and later removal via worktrunk (`wt`)) is owned by the dispatcher/human, not by you — never remove or switch it.
- Expand scope beyond the ticket. If the ticket is wrong or too big, stop and report back.

## Orient

1. Confirm you are in the intended worktree and on the assigned branch (named per the repo's prefix convention, e.g. `feat/…`/`feature/<feat>` or `fix/…`/`hotfix/<bug>`), not on the default branch.
2. Read the repo's `AGENTS.md` (and nested ones — nearest up-tree wins) for the conventions this stage needs: **verify commands** (build/lint/test), **commit conventions**, the **PR tool** (and draft policy), plus code style, boundaries, and any hard rules. Read them by meaning, wherever the repo states them — don't require a dedicated block. `AGENTS.md` is the authority for these **mechanical conventions** and overrides this skill's defaults on conflict — but it does **not** override this skill's safety gates (never self-merge, the plan/change/PR approval gates, draft-first, stay in scope, no secrets); those hold regardless of what a repo declares. If the repo has no `AGENTS.md` or is silent on a key, infer from repo signals (commit style from `git log`, commands from a Makefile/justfile/package scripts); if still ambiguous, ask once rather than assume.
3. Re-read the ticket end to end: its description and suggested acceptance criteria.

## Cross-check the ticket

Before planning, verify the ticket holds up against the current state of the project. Do not take it at face value.

- Read the code, tests, and docs in the areas the ticket touches.
- Confirm the described problem/gap actually exists as stated, and that the suggested acceptance criteria are correct, complete, and achievable against the real project.
- Note anything the ticket missed, got wrong, already-done, or that conflicts with the codebase or `AGENTS.md`.

If the ticket materially misaligns with reality (wrong, already resolved, too big, or based on a false premise), stop and report back with what you found — do not silently reinterpret or expand it. Propose a corrected understanding or a refined set of acceptance criteria for the human to confirm.

## Plan and get approval

Produce a short implementation plan as a sequence of **small, individually verifiable steps** — each step a coherent change that can be built/linted/tested on its own, ordered so the branch stays green.

Summarize the plan for the human:

- The confirmed (or refined) acceptance criteria this plan satisfies.
- The ordered steps, each with a one-line intent and how it will be verified.
- Any assumptions, risks, or open questions surfaced during the cross-check.

Stop and ask for approval. Do not write feature code until the human approves the plan. If they request changes, revise and re-present before proceeding.

## Implement

Work the approved plan one step at a time, in small coherent increments. Follow the existing conventions and structure of the codebase — match the surrounding style; do not restructure unrelated code. Keep the change focused on the approved acceptance criteria. If implementation reveals the plan was wrong, stop, report, and re-confirm rather than drifting from it.

## Verify

Discover the actual commands from the repo's `AGENTS.md` (or the project's standard tooling — Makefile/justfile target, package scripts, `cargo`/`go`/`pnpm`, etc.). Do not assume; use what the repo declares.

The ticket is **not complete** until all of the following pass:

- **Build** — the project builds/compiles cleanly.
- **Lint / format** — the linter and formatter pass.
- **Tests** — the test suite passes; add or update tests to cover the new behavior.

Iterate until every check is green. Do not bypass, skip, or disable failing checks; fix the cause or, if genuinely blocked, stop and report why.

Distinguish a check that fails *on your change* (must fix — never bypass) from a check that fails because the **local tooling environment is broken** (e.g. a pre-commit hook whose cached linter binary panics due to a toolchain version mismatch). For the latter, run the underlying tool directly to confirm your change is actually clean, then proceed and **note the bypass and your equivalent verification in the PR body** so the reviewer confirms CI is green. Do not silently `--no-verify`.

## Review the changes and get approval

Once every check is green, stop and present the completed work for review before doing anything else. Summarize for the human:

- What changed, grouped by area (files/modules touched and why).
- How each approved acceptance criterion is now satisfied.
- How it was verified (which build/lint/test commands were run and their results).
- Anything notable: trade-offs made, follow-ups deferred, or deviations from the plan.

Stop and ask for approval. The human may approve, or ask questions about the implementation — answer them and, if they request changes, make them, re-verify, and re-present. Do not proceed to commit or PR until the human approves the change itself.

For an independent fresh-eyes pass on the change before the PR exists, run `reviewing-pull-requests` in local mode (a separate subagent reviewing this worktree). It is review-only and never merges.

## Branch hygiene

- Commit on the feature branch using the repo's commit conventions (read `AGENTS.md`; e.g. conventional commits, issue refs).
- Keep the branch clean: no stray files, no unrelated changes, no committed secrets.
- Rebase onto the current base branch before opening the PR if the branch has fallen behind, then re-run verification.

## Open the pull request

Every `gh` (or declared PR-tool) operation requires the human's approval first — never run one unprompted. The PR is created **draft-first**, the same way tickets are: present the draft, then create only on approval.

1. Draft the PR without creating it. Present the exact **title** and **body** you intend to submit. The body must:
   - Describe what changed and why.
   - Link the ticket it implements (reference the ticket ID/URL per repo convention).
   - Summarize how it was verified (which checks were run).
2. Stop and ask for approval of the draft. If the human requests edits, revise and re-present.
3. On approval, create the PR with `gh pr create` (or the repo's declared PR tool) using exactly the approved title and body.
4. Report the PR link back.

Do not merge. CI and human review are the gate.

## Hard rules

- Never put secrets in code, commits, PR bodies, commands, or tool arguments. Refer to any discovered secret as redacted and report only its location.
- Stay within scope and within this worktree/branch.
- Never self-merge or push to the default branch.
- Never run a `gh` (or PR-tool) operation without the human's explicit approval, and never create the PR before its draft is approved.

## Definition of Done

- Ticket cross-checked against the project; acceptance criteria confirmed or refined with the human.
- An implementation plan of small verifiable steps presented and approved before coding.
- Assigned ticket implemented against the approved acceptance criteria.
- Build clean, lint/format passing, tests passing (new behavior covered).
- Completed changes summarized and approved by the human before commit/PR.
- Changes committed on the feature branch, branch clean and rebased on base.
- PR draft (title + body) presented and approved before creation; PR then opened and linked to the ticket, with a verification summary.
- A short report back: what was done, how verified, and the PR link. The merge is left to CI + human review.

## Related

Once the PR is open, review is done separately with fresh context via `reviewing-pull-requests` — not by you. Do not review or merge your own work.
