# Agentic SDLC Skills

These six skills define a closed software-development loop. Each is a distinct
**role** with a fixed place in the pipeline, its own scope, and hard boundaries
it will not cross. Together they take a repository from "what needs doing?" all
the way to a merged, reviewed change — with a human approval gate at every hand-off.

Two standalone feeders (`generating-tickets`, `prioritizing-work`) and the remote
merge gate (`reviewing-pull-requests`) run at the repo root. Between them sits the
**`plan-task` loop** — a two-session unit that takes one ticket from plan to open
PR: **session 1** reasons, coordinates, reviews, and opens the PR (`edit: deny` —
never writes feature code); **session 2** is the only session that writes code.

## The loop

```
        ┌───────────────────────┐
        │  generating-tickets   │  triage — review main, draft tickets
        └───────────┬───────────┘
                    │ backlog
                    ▼
        ┌───────────────────────┐
        │    prioritizing-work  │  planner — rank backlog, dispatch a planner
        └───────────┬───────────┘
                    │ dispatch (ticket → planner)
                    ▼
   ╔════════════════════════════════════════════════╗
   ║                 plan-task loop                  ║
   ║   ┌─────────────────────┐                       ║
   ║   │      plan-task      │ session 1 — plan +     ║
   ║   │   (coordination)    │ coordinate, no edits   ║
   ║   └──────────┬──────────┘                       ║
   ║              │ approved plan                     ║
   ║              ▼                                   ║
   ║   ┌─────────────────────┐                       ║
   ║   │    implement-task   │ session 2 — the only   ║
   ║   │    (writes code)    │ session that edits     ║
   ║   └──────────┬──────────┘                       ║
   ║              │ change                            ║
   ║              ▼                                   ║
   ║   ┌─────────────────────┐                       ║
   ║   │ reviewing-pull-req.  │ local mode — fresh-   ║
   ║   │    (local review)   │ eyes pre-PR check      ║
   ║   └──────────┬──────────┘                       ║
   ║              │ clean                             ║
   ║              ▼                                   ║
   ║   ┌─────────────────────┐                       ║
   ║   │      create-pr      │ session 1 — open PR    ║
   ║   └──────────┬──────────┘                       ║
   ╚══════════════╪═════════════════════════════════╝
                  │ pull request
                  ▼
        ┌───────────────────────┐
        │reviewing-pull-requests│ remote mode — merge gate, clean up
        └───────────┬───────────┘
                    │ follow-ups feed back
                    └──────────────► generating-tickets
```

## The roles

| Skill | Role | Runs in | Consumes | Produces |
| --- | --- | --- | --- | --- |
| `generating-tickets` | triage / proposer | repo root | `main` branch | draft tickets → backlog |
| `prioritizing-work` | planner / dispatcher | repo root | backlog | ranked shortlist; dispatched planner |
| `plan-task` | orchestrator (session 1) | coordination pane → worktree | one ticket | approved plan; owns worktree/workspace + review/PR coordination |
| `implement-task` | implementer (session 2) | one git worktree | approved plan | committed + pushed change |
| `create-pr` | PR opener (session 1) | worktree (git + gh) | reviewed change | an open PR |
| `reviewing-pull-requests` | reviewer / gate | worktree (local) or repo root (remote) | a change / PR | verdict; merge + cleanup |

`reviewing-pull-requests` appears twice on purpose: **local mode** runs inside the
loop (a pre-PR self-check within session 2), **remote mode** is the standalone
authoritative merge gate at the root. Same review logic, different launch location.

Each skill also cross-links its neighbours in its own `## Related` section, so the
agent can suggest the next step without you naming it.

## Shared invariants

Every skill in the loop upholds the same contract — read these here once instead
of re-deriving them from each file:

- **AGENTS.md is the source of truth.** Skills are repo-agnostic. Build/test/lint
  commands, ticketing system, branch/PR conventions, and hard rules all come from
  the target repo's `AGENTS.md`, which each skill reads first and which overrides
  the skill on conflict. Do **not** DRY these into a shared include — skills stay
  self-contained; the repo's `AGENTS.md` is the single source of truth instead.
- **Human approval gates every write.** Nothing that mutates state (tickets, code,
  PRs, merges) happens without an explicit approval step. Drafts are presented first.
- **Secrets are never emitted.** No secret ever appears in a ticket, prompt, commit,
  PR body, command, or tool argument; discovered secrets are reported by location only.
- **Session split, no self-merge.** Within the loop, session 1 reasons/coordinates/
  reviews/opens the PR under `edit: deny` and session 2 is the only session that
  writes feature code — so the work is never reviewed by the context that wrote it.
  CI + human review own the merge decision; merge/cleanup happens only from the repo
  root (remote mode), never from inside the worktree.
- **Tooling delegation.** Herdr mechanics live in the `herdr` skill; worktrees are
  managed by worktrunk (`wt`). Skills reference these rather than hardcoding syntax.

## How these are managed

The skills are authored here in dotfiles and installed via `agents.toml`
(reconciled with `@sentry/dotagents`). The six SDLC skills point back at this repo:

```toml
[[skills]]
name = "generating-tickets"
source = "pedrobarco/dotfiles"
path = "agents/.agents/skills/generating-tickets"
branch = "master"
```

Reconcile after editing any skill:

```bash
npx --yes @sentry/dotagents@latest --user install
```

## Editing guidance

- The frontmatter `description` is what the agent matches on at runtime — it is the
  single biggest lever on whether the right skill fires. Keep the explicit
  *"Use when"* / *"Not for"* / boundary structure.
- Each skill should carry `evals/trigger-eval.json`. Run these (via `skill-creator`)
  after changing a description to catch trigger regressions before they ship. The
  newer loop skills (`plan-task`, `implement-task`, `create-pr`) don't have evals yet.
- Keep each skill's `## Scope`, `## Hard rules`, and `## Definition of Done`
  sections — they are the guardrails that keep roles from bleeding into each other.
