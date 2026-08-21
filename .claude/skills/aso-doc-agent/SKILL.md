---
name: aso-doc-agent
description: Autonomously close ASO (AEM Sites Optimizer) documentation gaps against Jira epic SITES-49539 — picks the single highest-priority undocumented feature, drafts content matching this repo's tone/format, requests screenshots/video via Slack when needed, opens a capped reviewer-balanced PR, checks review status on every open PR every run, and learns from review feedback. Designed to run headless on a daily schedule (see USAGE.md). Supports --ticket, --setup.
user_invocable: true
argument-hint: "[--ticket SITES-XXXXX] [--setup]"
---

# ASO Doc Agent

Closes one ExperienceLeague documentation gap per run against the backlog tracked in
[SITES-49539](https://jira.corp.adobe.com/browse/SITES-49539). One run = one feature =
at most one PR. Never picks a whole page or multiple tickets in a single run.

**Usage:**
- `/aso-doc-agent` — normal run: draft, request media if needed, open a real PR
- `/aso-doc-agent --ticket SITES-XXXXX` — process one specific ticket instead of auto-picking
- `/aso-doc-agent --setup` — install the daily launchd schedule (see `scripts/aso-doc-agent-setup.sh`)

**Arguments:** $ARGUMENTS

## Setup mode (`--setup`)

Run `bash .claude/scripts/aso-doc-agent-setup.sh` and stop — it installs/refreshes the
launchd job described in USAGE.md. Does not touch Jira/GitHub/Slack.

## Before starting

1. Confirm cwd is the repo root: `experience-manager-sites-optimizer.en` (check for `guidelines.md` and `.claude/skills/aso-doc-agent/config.yml`).
2. Read `.claude/skills/aso-doc-agent/config.yml` — all team-specific values live there.
3. Read `.claude/skills/aso-doc-agent/references/pipeline.md` — the full step-by-step. This file is the summary; the pipeline reference is the source of truth for execution order.
4. Read `.claude/skills/experience-league-markdown/SKILL.md` before writing or editing **any** `.md` file under `help/` — every doc write in this pipeline must conform to it (frontmatter, shortcodes, HTML allowlist, etc.). This is not optional; validation failures block merge.
5. If a video needs embedding once captured, use `.claude/skills/experience-league-video-upload/SKILL.md` for the upload flow — but note that skill stops before submit; this agent never submits a video upload itself (see Media below).

## Core loop (one run)

```
0. Preflight            — cwd, gh auth, config present, state dir present
1. Reconcile             — check reviews on every open PR (merge if approved, log if
                            changes requested + extract a learning); merged/closed PRs ->
                            update state; open draft PRs -> check Jira for new
                            attachments/comments -> attach media -> mark ready
2. PR cap gate           — count open PRs (label=aso-doc-agent). If >= pr.max_open: log,
                            skip steps 3-6, go to 7
3. Pick ticket           — highest priority, unpicked, status = open_status, under the epic
4. Research + draft      — research source code, Wiki, Slack, and merged PR history for
                            ground truth; read 2-3 tone analogs; draft v1; iterate against
                            all research findings; decide file target (new page vs section
                            of an existing page); decide if media is needed and what to capture
5. Media gate            — if needed: send/escalate Slack request (see Media below)
6. Publish               — branch, write (validated against experience-league-markdown),
                            commit, push, open PR (draft if media still pending), label,
                            assign reviewer, comment + label the Jira ticket
7. Run summary           — log what happened
```

Full detail for every step: `references/pipeline.md`.

## Single-feature scope (mandatory)

The epic's 39 child stories are already scoped to one feature each (e.g. "[ASO Docs]
Canonical opportunity how-to", "[ASO Docs] Slack notifications"). **Never** expand scope
to a whole page, a whole opportunity-type category, or multiple tickets in one run — pick
one ticket, touch only the section(s) that ticket describes, stop.

## Research before drafting (mandatory, multi-source)

Never draft from the Jira ticket alone. Step 4 in `references/pipeline.md` requires
checking all of these before writing anything, in this trust order when they disagree
(source code wins over docs/PRs, which win over Slack chatter, which wins over guessing):

1. **Source code** (`research.code_repos` in config.yml) — the feature's `*OpportunityAdapter.tsx`/`*SuggestionAdapter.tsx`, its `use*Data.ts` hook, its `.l10n.ts` strings. Ground truth for data shape, category, and real product copy.
2. **Wiki** (`mcp__Adobe-Wiki__search_wiki_content` / `get_wiki_content`) — design intent, specs, terminology, existing screenshots.
3. **Slack** (`mcp__Slack__slack_search_messages`) — announcements, design discussion, anything that changed recently.
4. **Merged GitHub PRs** (`gh search prs` / `gh pr list --search`, across `research.code_repos`) — implementation rationale, review discussion, screenshots in PR descriptions.
5. **Tone analogs** — 2-3 sibling pages under `help/documentation/opportunities/` (per-opportunity how-tos live here — `help/opportunity-types/*.md` are category landing pages with card grids, not the how-to content itself) or elsewhere under `help/documentation/` for non-opportunity tickets.
6. **`references/review-learnings.md`** — accumulated lessons from past PR review feedback.

Then: draft v1, **iterate** — re-check the draft against everything found in 1-4 before
finalizing (pipeline.md step 4.9) — and only flag `<!-- CONFIRM -->` for what's still
genuinely unconfirmed after all five sources.

`experience-league-markdown` governs syntax (frontmatter, headings, note/tab/video
shortcodes, HTML allowlist — violations fail validation). `guidelines.md`/`contributing.md`
govern voice: US English, Microsoft Manual of Style, simple sentences, "AEM" after first
full mention, no version-specific references, no bug/workaround documentation, screenshots
used judiciously and never annotated.

## Learn from review feedback

Every run checks reviews on every open PR (Reconcile, step 1). When a human requests
changes, read the review comments and decide: is this generalizable, or a one-off fix?

- **Generalizable** (a pattern that will recur — wrong file placement, a missing section,
  an unconfirmed claim that should have been flagged instead) -> append a dated,
  ticket-linked entry to `references/review-learnings.md`. Format is in that file.
- **One-off/mechanical** (typo, broken link, a fix specific to that PR) -> nothing to
  record; that class of issue doesn't need a durable lesson.

`references/review-learnings.md` is read at the start of every future draft (Research +
draft, step 4) — this is the actual mechanism by which the agent's output improves over
time instead of a human repeating the same correction on every PR.

## Media requests (Slack out, Jira in)

Slack thread-reading and usergroup-listing are **not available** in this environment
(`missing_scope` on `conversations.replies` / `usergroups.users.list` as of 2026-08-20).
Sending a DM (`slack_send_dm`) and looking up a user by email (`slack_lookup_user`) do
work. The pipeline is designed around that constraint:

- **Ask via Slack DM.** When a draft needs a screenshot or video, DM `media.contacts_in_order[0]`
  (sandsinh) with what to capture and the exact URL(s) (customer-facing app page and/or
  internal page) to capture it from.
- **Answer via Jira, not Slack.** The contact replies by attaching the image, or attaching
  the video and posting the resulting `video.tv.adobe.com` URL as a Jira comment on the
  ticket. The next run checks the ticket's attachments/comments (`list_attachments`,
  `get_jira_comments`) — this sidesteps the broken Slack read scopes entirely.
- **Escalate, don't wait forever.** No asset within `media.escalate_after_hours` (5 days)
  -> DM the next contact (kanishka), referencing that sandsinh was already asked. No asset
  within `media.give_up_after_hours` (10 days) -> ship the doc without media, with an
  inline note. No timeout-based auto-merge — the PR still waits for a human review either way.
- Screenshots go straight into the PR branch as image assets (`help/**/assets/`) per
  `experience-league-markdown` image syntax. Videos require the `experience-league-video-upload`
  skill's manual submit step — this agent only embeds a URL a human already obtained; it
  never automates that submit.

## PR discipline

- Cap: never more than `pr.max_open` (3) open `aso-doc-agent`-labeled PRs at once. Check
  live GitHub state every run (source of truth, not the local state file).
- Reviewer: whichever of the two configured reviewers has fewer currently-open
  `aso-doc-agent` PRs assigned to them as reviewer. Never assign both to the same PR.
- **Every open PR gets its review status checked every run** (`pr.check_reviews_every_run`).
  Approved -> merge now (human-approved, not autonomous). Changes requested -> leave open,
  log it, extract a learning (see above). No timeout-based auto-merge exists — an
  unreviewed PR simply stays open until a human reviews it.
- Draft PRs stay draft until media is resolved (attached or given-up-on) — never open a
  PR with a broken image reference or an unfilled `>[!VIDEO]` placeholder.
- No `.github/PULL_REQUEST_TEMPLATE.md` exists in this repo (unlike the UI repo) — PR body
  format is defined in `references/pipeline.md` step 6.

## Key paths

- Config: `.claude/skills/aso-doc-agent/config.yml`
- Pipeline detail: `.claude/skills/aso-doc-agent/references/pipeline.md`
- Review learnings (tracked in git): `.claude/skills/aso-doc-agent/references/review-learnings.md`
- State (gitignored): `.claude/skills/aso-doc-agent/state/`
- Scheduler install: `.claude/scripts/aso-doc-agent-setup.sh`
- How to use / operate this agent: `.claude/skills/aso-doc-agent/USAGE.md`

Start with Preflight (pipeline.md step 0).
