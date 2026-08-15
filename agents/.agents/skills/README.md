# Agentic SDLC Skills

These four skills define a closed software-development loop. Each is a distinct
**role** with a fixed place in the pipeline, its own scope, and hard boundaries
it will not cross. Together they take a repository from "what needs doing?" all
the way to a merged, reviewed change — with a human approval gate at every hand-off.

## The loop

```
        ┌──────────────────────┐
        │  generating-tickets  │  triage — review main, draft tickets
        │      (step 1)        │
        └──────────┬───────────┘
                   │ backlog
                   ▼
        ┌──────────────────────┐
        │   prioritizing-work  │  planner — rank backlog, dispatch a developer
        │      (step 2)        │
        └──────────┬───────────┘
                   │ dispatch (worktree + workspace)
                   ▼
        ┌──────────────────────┐
        │ implementing-features│  developer — implement one ticket, open a PR
        │      (step 3)        │
        └──────────┬───────────┘
                   │ pull request
                   ▼
        ┌──────────────────────┐
        │reviewing-pull-requests│ reviewer/gate — verdict, merge, clean up
        │      (step 4)        │
        └──────────┬───────────┘
                   │ follow-ups feed back into step 1
                   └───────────────► generating-tickets
```

## The roles

| Step | Skill | Role | Runs in | Consumes | Produces |
| --- | --- | --- | --- | --- | --- |
| 1 | `generating-tickets` | triage / proposer | repo root | `main` branch | draft tickets → backlog |
| 2 | `prioritizing-work` | planner | repo root | backlog | ranked shortlist; dispatched developer |
| 3 | `implementing-features` | developer | one git worktree | one ticket | a pull request |
| 4 | `reviewing-pull-requests` | reviewer / gate | repo root (remote) or worktree (local) | a PR / branch | verdict; merge + cleanup |

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
- **No self-merge.** The developer never reviews or merges its own work; CI + human
  review own the merge decision. Merge/cleanup happens only from the repo root.
- **Tooling delegation.** Herdr mechanics live in the `herdr` skill; worktrees are
  managed by worktrunk (`wt`). Skills reference these rather than hardcoding syntax.

## How these are managed

The skills are authored here in dotfiles and installed via `agents.toml`
(reconciled with `@sentry/dotagents`). The four SDLC skills point back at this repo:

```toml
[[skills]]
name = "generating-tickets"
source = "pedrobarco/dotfiles"
path = "agents/.agents/skills/generating-tickets"
```

Reconcile after editing any skill:

```bash
npx --yes @sentry/dotagents@latest --user install
```

## Editing guidance

- The frontmatter `description` is what the agent matches on at runtime — it is the
  single biggest lever on whether the right skill fires. Keep the explicit
  *"Use when"* / *"Not for"* / boundary structure.
- Each skill has `evals/trigger-eval.json`. Run these (via `skill-creator`) after
  changing a description to catch trigger regressions before they ship.
- Keep each skill's `## Scope`, `## Hard rules`, and `## Definition of Done`
  sections — they are the guardrails that keep roles from bleeding into each other.
