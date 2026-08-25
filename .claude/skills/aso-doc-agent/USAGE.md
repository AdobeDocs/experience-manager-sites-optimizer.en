# ASO Doc Agent — Usage

What this is, how it runs, and what to do when it needs you.

## What it does

Every day, this agent picks the single highest-priority undocumented ASO feature from
[SITES-49539](https://jira.corp.adobe.com/browse/SITES-49539)'s backlog (39 tickets, e.g.
"Canonical opportunity how-to", "Slack notifications"), writes one piece of documentation
for it in this repo's house style, and opens a PR — assigning whichever of the two
configured reviewers (`sandsinh_adobe` / `kanishka_adobe`) currently has fewer open
review requests from this agent. If the feature needs a screenshot or video, it asks for
one over Slack before finishing the PR.

Every run also checks review status on every open PR: approved PRs get merged
immediately, and changes-requested feedback gets read and, when it's a generalizable
lesson (not a one-off typo), recorded so future drafts don't repeat the same mistake.

One run = one feature = at most one PR. It never touches more than one ticket per run,
and never opens more than 3 PRs at once (waits for existing ones to merge/close first).

## Where everything lives

| What | Path |
|---|---|
| How it decides what to do | `.claude/skills/aso-doc-agent/SKILL.md` |
| The exact step-by-step | `.claude/skills/aso-doc-agent/references/pipeline.md` |
| Team-specific settings (edit this to change reviewers, cap, escalation timing) | `.claude/skills/aso-doc-agent/config.yml` |
| Lessons learned from PR review feedback (tracked in git, read before every draft) | `.claude/skills/aso-doc-agent/references/review-learnings.md` |
| Local run state (gitignored — safe to delete, it'll rebuild) | `.claude/skills/aso-doc-agent/state/` |
| Daily schedule installer | `.claude/scripts/aso-doc-agent-setup.sh` |
| Permission allowlist for headless runs | `.claude/settings.local.json` (gitignored, machine-local) |

## Running it

- **Manually, in a normal session:** `/aso-doc-agent` (or `/aso-doc-agent --ticket SITES-XXXXX`)
- **Headless, one-off:** `claude -p "/aso-doc-agent"` from the repo root
- **Daily, unattended:** already installed via `launchctl` (see below) — runs at 07:53 local time every day, no action needed

### Installing / changing the daily schedule

```bash
bash .claude/scripts/aso-doc-agent-setup.sh
```

Installs a `launchd` job (`~/Library/LaunchAgents/com.sandsinh.aso-doc-agent.plist`) that
runs `claude -p "/aso-doc-agent"` from this repo daily. Re-run the script any time you
edit the schedule inside it (default: 07:53 local). This only works while your machine is
on and awake at that time — launchd does not run missed jobs retroactively, but will run
the next scheduled time normally.

```bash
launchctl list | grep com.sandsinh.aso-doc-agent   # confirm it's loaded
launchctl start com.sandsinh.aso-doc-agent         # trigger a run right now, don't wait for 07:53
launchctl unload ~/Library/LaunchAgents/com.sandsinh.aso-doc-agent.plist  # stop it
```

Logs from each scheduled run land in `.claude/skills/aso-doc-agent/state/launchd.out.log`
and `launchd.err.log`.

## What you'll be asked to do

- **A Slack DM from the agent** (sent as you, to you — sandsinh first, kanishka on
  escalation) asking for a screenshot or video, with exact capture steps and the URL(s) to
  use. **Reply on the linked Jira ticket, not in Slack**: attach the screenshot directly,
  or for video, upload it through the usual Experience League video form
  (`experience-league-video-upload` skill) and paste the resulting `video.tv.adobe.com`
  link as a Jira comment. The next run picks it up automatically.
- If nobody responds within **5 days**, the request escalates from sandsinh to kanishka
  automatically. After **10 days** with no response from either, the agent ships the doc
  without media and adds an inline note. There's no timeout-based auto-merge — the PR
  still waits for an actual human review, however long that takes.
- **A PR to review** — assigned to whichever of you two has fewer agent-opened PRs
  currently awaiting review. Draft PRs mean media is still pending; they flip to
  ready-for-review automatically once the asset shows up. Approve it and the agent merges
  it on the next run — no separate merge step needed from you.
- **If you request changes**, the agent reads your comments on the next run. Generalizable
  feedback (not a typo/link fix) gets written to `references/review-learnings.md` so the
  same correction doesn't need repeating on a future PR.

## Adjusting behavior

Edit `.claude/skills/aso-doc-agent/config.yml` (tracked in git — changes affect every
future run, on this machine or anyone else's who clones the repo):

- `pr.max_open` — how many open PRs before the agent pauses picking new tickets (default 3)
- `pr.stale_after_hours` — how long a `CHANGES_REQUESTED` PR can sit before it stops counting toward `pr.max_open` (default 336 = 14 days); it stays open, this only unblocks new picks
- `github.reviewers` — who gets assigned, and in what balance
- `media.contacts_in_order` / `escalate_after_hours` (default 120 = 5 days) / `give_up_after_hours` (default 240 = 10 days) — who's asked, in what order, and how patiently; both are measured from the original request, so escalating doesn't push out the give-up date
- `pr.check_reviews_every_run` — turn off the review-check step (not recommended; this is how merges and learnings happen)

## If it stalls on a permission prompt

Headless (`claude -p`, launchd) runs have no terminal to prompt in — an unlisted tool call
will just fail rather than hang. If a run's log shows a permission denial for a command
the pipeline legitimately needs, add it to the `permissions.allow` list in
`.claude/settings.local.json` (not tracked in git — machine-local; every developer running
this agent needs their own copy with their own scoped allowlist).

## If it stops making progress entirely

Check, in order:
1. `gh pr list --repo Adobe-Enterprise-Docs/experience-manager-sites-optimizer.en --label aso-doc-agent --state open` — if this shows 3, it's waiting on reviews, not stuck.
2. Jira: is there an eligible `New` ticket left under SITES-49539 that isn't already `aso-doc-agent-picked`? The label is only ever applied once a branch+PR exist (pipeline.md Step 6.10), so a crashed run shouldn't leave a labeled-but-unpublished ticket — if you still find one (e.g. a label added by hand), remove it manually to make the ticket eligible again.
3. `.claude/skills/aso-doc-agent/state/launchd.err.log` for the most recent run's error.
4. If a run's summary shows "epic backlog fully covered" or "nothing to do here" but you know there should be eligible work, treat that as suspicious — those messages are reserved for genuinely empty results. An actual Jira/GitHub/Slack error is logged separately and should show up as its own line in `launchd.err.log` instead of hiding behind one of those messages.
