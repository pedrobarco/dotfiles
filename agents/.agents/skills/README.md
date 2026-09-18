# Agentic SDLC Skills

These six skills are the capabilities of an agentic software-development loop.
Each is a **self-contained capability** with its own `## Run context` (the **role**
it runs as and where it runs), its own scope, and hard boundaries it will not cross.
No skill knows its predecessor or successor — a **human sequences them**, approving at
every hand-off. Together they can take a repository from "what needs doing?" all the
way to a merged, reviewed change.

Skills speak in **roles** (`planner`, `implementer`, `reviewer`, `pr-reviewer`).
OpenCode models are bound on the named agent in `opencode.json`. Cursor models
are in the role-launch matrix: Grok for planner/reviewer, Composer for implementer.
Spawners start a role with `herdr --kind` plus the role-launch args after `--`.

Two sanctioned exceptions to "no skill launches another" exist, both requiring a live
Herdr workspace and neither acting as a gate: `prioritizing-work` may **dispatch** a planner
into the task's `<repo>-<slug>-plan` workspace to start `planning-tasks` (a single entry launcher);
`implementing-tasks` may **start** the implementer in `<repo>-<slug>-dev` when it is not
already running there, and may **auto-launch** the local `reviewing-pull-requests` review once its
branch is pushed — but only when the task's main `<repo>-<slug>-plan` workspace is live to route
the verdict to; otherwise it stops and reports.
Every state mutation (plan, commit, PR, merge) still needs explicit human approval.

## Typical flow (human-driven)

A human runs the capabilities in whatever order the work needs; a common path is:

1. `generating-tickets` — review `main`, draft a backlog.
2. `prioritizing-work` — rank it; optionally dispatch a planner to start step 3.
3. `planning-tasks` — cross-check one ticket, produce an approved plan.
4. `implementing-tasks` — start the implementer in the `<repo>-<slug>-dev` workspace if needed, then build the plan in the feature worktree; commit and push.
5. `reviewing-pull-requests` (local) — fresh-eyes check before a PR, in the `<repo>-<slug>-plan` workspace; `implementing-tasks` auto-launches it there when that workspace is live, else a human runs it.
6. `creating-pull-requests` — open the draft PR for the reviewed change.
7. `reviewing-pull-requests` (remote) — merge gate on the open PR; merge + clean up.

Each step is entered directly and gated by a human. Review follow-ups can loop back to
`generating-tickets`; blocking findings loop back to `implementing-tasks`.

## The capabilities

| Skill | Role | Runs in | Produces |
| --- | --- | --- | --- |
| `generating-tickets` | `planner` (read-only) | repo root, clean `main` | draft tickets → backlog |
| `prioritizing-work` | `planner` / dispatcher | repo root | ranked shortlist; optional dispatched planner |
| `planning-tasks` | `planner` | `<repo>-<slug>-plan` workspace, repo root | an approved plan (no worktree) |
| `implementing-tasks` | `implementer` (starts that role if needed) | `<repo>-<slug>-dev` workspace, its own feature worktree | committed + pushed change |
| `creating-pull-requests` | `planner` | `<repo>-<slug>-plan` workspace, repo root, targets the worktree (git + gh) | an open draft PR |
| `reviewing-pull-requests` | `reviewer` (local) / `pr-reviewer` (remote) | `<repo>-<slug>-plan` workspace, repo root (both modes) | verdict; merge + cleanup (remote) |

`reviewing-pull-requests` runs in two modes, both from the `<repo>-<slug>-plan` workspace at
the repo root: **local** (a fresh-eyes check of a change before a PR exists, reading the
feature worktree's diff) and **remote** (the authoritative merge gate on an open PR). Same
review logic; only the subject reviewed and the post-verdict powers differ.

Each skill also cross-links related capabilities in its own `## Related` section.

## Roles and models

Skills name **roles**. Spawners (`prioritizing-work`, `implementing-tasks`) start a role
with `herdr agent start <name> --kind <kind> --pane <id> -- <role args>`. The task is
always delivered afterward via `herdr agent prompt`, never as native launch args.

| Provider | herdr kind |
| --- | --- |
| auggie | `auggie` |
| opencode | `opencode` |
| claude | `claude` |
| cursor | `cursor` |

| Role | OpenCode | Cursor | claude / auggie |
| --- | --- | --- | --- |
| `planner` | `--agent planner` | `--model cursor-grok-4.6-high-fast` | none (CLI default) |
| `implementer` | `--agent implementer` | `--model composer-2.5` | none (CLI default) |
| `reviewer` | `--agent reviewer` | `--model cursor-grok-4.6-high-fast` | none (CLI default) |
| `pr-reviewer` | `--agent pr-reviewer` | `--model cursor-grok-4.6-high-fast` | none (CLI default) |

**Current model bindings:**

| Role | Skills that run as it | OpenCode (`opencode.json`) | Cursor (role-launch matrix) |
| --- | --- | --- | --- |
| `planner` | `generating-tickets`, `prioritizing-work`, `planning-tasks`, `creating-pull-requests` | `planner` → `augment/claude-opus-4-8-high` (`edit: deny`) | Grok — `cursor-grok-4.6-high-fast` (no `--mode plan`) |
| `implementer` | `implementing-tasks` | `implementer` → `augment/claude-sonnet-4-6` | Composer — `composer-2.5` |
| `reviewer` | `reviewing-pull-requests` (local) | `reviewer` → `augment/claude-opus-4-8-medium` (`edit: deny`) | Grok — `cursor-grok-4.6-high-fast` |
| `pr-reviewer` | `reviewing-pull-requests` (remote) | `pr-reviewer` → `augment/claude-opus-4-8-medium` (`edit: deny`) | Grok — `cursor-grok-4.6-high-fast` |

Change OpenCode models in `opencode.json`; change Cursor models in this matrix.
Do **not** start the `-plan` agent with Cursor `--mode plan` — that session is reused
for ticket writes and `creating-pull-requests`. OpenCode's top-level `model` is only
used when no `--agent` is passed; spawned SDLC sessions should always pass `--agent`.
claude / auggie use that CLI's default unless the human overrides. Both OpenCode
reviewer agents are `primary` so Herdr can start them as interactive panes.

## Naming — one slug per task

Task artifacts key off a **single `<slug>`**, coined **once** and reused everywhere so
they correlate (`<repo>` = repository name). If `prioritizing-work` dispatches, it coins
the slug into the planner workspace/agent name and `planning-tasks` recovers it from there; otherwise
the slug is coined from the branch/ticket when first needed. It is never re-derived — remote-mode
teardown recovers it (from the branch/ticket) and targets these names directly:

| Entity | Name |
| --- | --- |
| branch | the repo's branch naming convention (prefix from `AGENTS.md`, else `feature/<slug>` or `hotfix/<slug>`) |
| worktree | the task's `<slug>` (its directory; `wt` computes the path) |
| main workspace | `<repo>-<slug>-plan` (repo root; hosts plan, review, creating-pull-requests) |
| dev workspace | `<repo>-<slug>-dev` (rooted at the feature worktree; hosts the implementer) |
| planner agent | `<repo>-<slug>-plan` |
| implementer agent | `<repo>-<slug>-dev` |
| reviewer agent | `<repo>-<slug>-review` (runs in the `-plan` workspace) |

The `<repo>-<slug>-plan` workspace at the repo root hosts the reasoning-role capabilities
(`planning-tasks`, `creating-pull-requests`, and both review modes); the `<repo>-<slug>-dev` workspace hosts the
implementer inside the feature worktree. Local review runs in the `-plan` workspace, reading the
worktree's diff via `git -C <worktree>`.

## Shared invariants

Every skill upholds the same contract — read these here once instead
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
- **Role separation, no self-merge.** The role that writes feature code (implementer,
  `<repo>-<slug>-dev`) is never the role that reviews or opens the PR (reasoning/reviewer,
  `edit: deny`, `<repo>-<slug>-plan`/`-review`), and review runs with fresh context — so work
  is never reviewed by the context that wrote it. CI + human review own the merge decision;
  merge/cleanup happens only in remote mode from the `<repo>-<slug>-plan` workspace at the repo
  root, never in local mode.
- **Tooling delegation.** Herdr mechanics live in the `herdr` skill. Worktrees use worktrunk
  (`wt`) as the engine, surfaced through Herdr's native `worktree` integration (`herdr worktree
  open`/`list` to create + register, `wt remove` then `herdr workspace close` to tear down) so
  each checkout becomes its own workspace with worktrunk's setup/teardown hooks. Humans get the
  same via the enabled **worktrunk** Herdr plugin (an fzf picker); skills drive the underlying
  commands non-interactively and reference these rather than hardcoding syntax.

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
  newer loop skills (`planning-tasks`, `implementing-tasks`, `creating-pull-requests`) don't have evals yet.
- Keep each skill's `## Run context`, `## Scope`, `## Hard rules`, and `## Definition
  of Done` sections — `## Run context` pins the **role** and where the skill runs, and
  the others are the guardrails that keep roles from bleeding into each other.
- Do **not** put OpenCode model IDs in skill Run context — bind those on the named
  agent in `opencode.json` and launch with `--agent`. Cursor models live in the
  role-launch matrix: Grok (`cursor-grok-4.6-high-fast`) for planner/reviewer,
  Composer (`composer-2.5`) for implementer. Do **not** add Cursor `--mode plan` —
  the `-plan` agent is reused for ticket writes and `creating-pull-requests`.
  Keep the three copies of the matrix (`prioritizing-work`, `implementing-tasks`,
  this README) in sync. OpenCode `reviewer` and `pr-reviewer` must stay `primary`
  so Herdr can start them as interactive panes.
