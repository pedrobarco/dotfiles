# Agentic SDLC Skills

These six skills are **roles**. Each owns one job, its inputs, its quality bar, its
approval gate, and its artifact. No skill knows its predecessor or successor.

## The capabilities

| Skill | In | Out | Stops after |
| --- | --- | --- | --- |
| `generating-tickets` | Clean default branch | Draft tickets → approved backlog | Tickets created (or drafts left pending) |
| `prioritizing-work` | Existing backlog | Ranked shortlist (top 3–5) | Presenting the shortlist |
| `planning-tasks` | Ticket ID or task description; default/base branch | Approved plan (AC, steps, branch name) | Plan approval |
| `implementing-tasks` | Approved plan **or** findings list; already on the feature branch | Pushed branch + verification summary | Push |
| `reviewing-pull-requests` | A branch or an open PR + ticket / AC | Clean / not-clean verdict | Presenting the verdict |
| `creating-pull-requests` | Pushed branch + ticket + verification + clean verdict | Draft PR URL | Reporting the PR link |

Human approval gates every write: ticket creation, plan, change-before-commit,
PR draft. Merge is not a skill.

## Skill contract

Every skill follows the same skeleton:

1. **Description** — this job only; no sibling skill names.
2. **Inputs** — what must already be true when the skill starts.
3. **Do the work**
4. **Approval gate** — the heading is required. Roles that do not write use
   `None. This role does not write.`
5. **Hard rules** — one secrets sentence, and the role's own "do not" list
6. **Outputs / Definition of Done**

Skills may read the target repo's `AGENTS.md` for mechanical conventions (ticketing,
branch prefix, verify commands, commit style, PR tool). `AGENTS.md` wins on those
mechanics; it never overrides safety gates (approval before writes, no secrets, no
self-review, no self-merge).

## Shared invariants

- **AGENTS.md is the source of truth** for repo mechanics. Skills stay
  self-contained; do not DRY conventions into a shared include.
- **Human approval gates every write.** Nothing that mutates state (tickets,
  code, PRs) happens without an explicit approval step.
- **Secrets are never emitted.** Discovered secrets are reported by location only.
- **No self-review, no self-merge.** The role that writes feature code does not
  review it or open the PR. The review role reaches a verdict; it does not merge.

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

- The frontmatter `description` is what the agent matches on at runtime. Keep it
  pushy about *this* job; describe what the skill is not for in generic terms
  (no sibling skill names).
- Each skill must carry `evals/trigger-eval.json`. Run these (via `skill-creator`)
  after changing a description.
- Keep **Inputs**, the work, **Approval gate**, **Hard rules**, and **Definition
  of Done**.
- Do not add a section that names another skill.
- Do not describe how the skill is launched, which checkout or workspace it
  runs in, or agent / slug / model names.
- Do not describe who runs next, merge, or teardown.
- If you need sequencing, put it outside these files, not in `SKILL.md`.
