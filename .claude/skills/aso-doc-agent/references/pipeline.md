# ASO Doc Agent — Pipeline

Referenced from `SKILL.md`. This is the source of truth for execution order; SKILL.md is
the summary. Read `config.yml` before starting — every value in `{braces}` below is a
config key.

## Step 0 — Preflight

1. `pwd` and check `guidelines.md` + `.claude/skills/aso-doc-agent/config.yml` both exist. If not, stop — wrong directory.
2. `gh auth status` — confirm `github.com` account `{github.reviewers}`'s org account (`sandsinh_adobe`) is active. If not active, `gh auth switch --user sandsinh_adobe` before any `gh` write.
3. `mkdir -p {state_dir}` if missing.
4. Read `{state_dir}/run-state.json` if it exists (else treat as `{"runs_completed": 0, "media_requests": {}}`). This file is the only durable local state — GitHub and Jira are the source of truth for everything else (PR status, ticket status).
5. `--ticket KEY` present -> skip Step 3's auto-pick, use KEY directly (still runs Steps 4-7). Otherwise auto-pick in Step 3.

## Step 1 — Reconcile previous runs

Run this every time, even on a cap-gated or otherwise empty run.

1. `gh pr list --repo {github.repo} --label {github.pr_label} --state open --json number,url,isDraft,headRefName,title,reviewDecision`
2. **Review check — every open PR, every run** (`pr.check_reviews_every_run`):
   - `gh pr view <number> --repo {github.repo} --json reviewDecision,reviews,comments`
   - `reviewDecision == "APPROVED"` -> merge now: `gh pr merge <number> --repo {github.repo} --merge` (this is a normal human-approved merge, not a timeout-based one). Comment on the linked Jira ticket that it merged, drop the PR from local tracking.
   - `reviewDecision == "CHANGES_REQUESTED"` -> do **not** auto-fix the PR in this version. Read the review comments (`gh api repos/{github.repo}/pulls/<number>/comments` for inline comments, plus the top-level review body from the `reviews` field) and run **Learn from feedback** below. Log the PR as awaiting author action in the run summary.
   - Anything else (no reviews yet, `REVIEW_REQUIRED` with no submitted review) -> nothing to do here.
3. **Learn from feedback.** For each review comment or review body that reads as a *generalizable* note about tone, structure, or content — not a one-off fix specific to that PR (compare "always mention the Ignored tab for opportunities with ignore support" vs. "typo on line 12") — append a dated, ticket-linked entry to `references/review-learnings.md`. Skip purely mechanical feedback (typos, broken links, lint) — fix those in the PR itself, they don't need a durable lesson. Exact entry format is documented in that file.
4. For each **draft** PR in that list, extract the Jira key from the branch name (`{github.branch_prefix}<KEY>-...`).
   - `mcp__Corp-Jira__list_attachments` + `mcp__Corp-Jira__get_jira_comments` on that key.
   - Look for: a new image attachment matching the requested capture, OR a comment containing a `video.tv.adobe.com` URL.
   - If found: `git fetch`/`checkout` the branch, add the image to `help/**/assets/` (if it's an image attachment, download via `download_attachment`) or fill the `>[!VIDEO](...)` placeholder (if a video URL comment), validate against `experience-league-markdown`, commit, push, `gh pr ready <number>`, comment on the PR "Media added — ready for review.", update `{state_dir}/media-requests.json` entry to `resolved`.
   - If not found: check elapsed time since the request in `{state_dir}/media-requests.json`. Apply the escalate/give-up logic from Step 5 here too (a draft PR left open across runs still needs its media chased).
5. For each **merged** or **closed** PR that was previously tracked in `run-state.json`, drop it from local tracking (GitHub is authoritative — nothing further to do).

## Step 2 — PR cap gate

1. Count open PRs from Step 1's `gh pr list` output.
2. If count >= `{pr.max_open}` (3): log `"cap reached ({count}/{pr.max_open} open) — skipping new ticket this run"`, jump to Step 7.
3. Else continue to Step 3.

## Step 3 — Pick a ticket

Skip entirely if `--ticket KEY` was passed (use KEY).

```
JQL: "Epic Link" = {jira.epic} AND status = "{jira.open_status}"
     ORDER BY priority DESC, created ASC
```

1. Run the search (`mcp__Corp-Jira__search_jira_issues`, `minimizeOutput: true`, fields limited to `key,summary,priority,status,labels`).
2. Walk results in order. Skip any ticket that:
   - already has the `{jira.picked_label}` label, OR
   - already has an existing branch `{github.branch_prefix}<KEY>-*` on the remote (`git ls-remote --heads origin '{github.branch_prefix}<KEY>-*'`), OR
   - already has an open or merged PR (cross-check against Step 1's list / `gh pr list --state all --search <KEY>`).
3. First ticket that passes all three checks is the pick. If none pass, log `"epic backlog fully covered or all in flight"` and go to Step 7.
4. Add `{jira.picked_label}` to the ticket immediately (`update_jira_issue`, merge with existing labels) — this is the "claim" so a second concurrent run (or a human re-running the same day) doesn't double-pick.

## Step 4 — Research + draft

Research comes first and is **multi-source** — never draft from a single input (the Jira
ticket alone, or just reading sibling docs). Every source below either confirms or
corrects the others; contradictions get resolved by trusting source code > Wiki/PR docs >
Slack discussion > the doc-writer's own inference, in that order, and get flagged inline
as `<!-- CONFIRM -->` when they can't be resolved.

0. **Accumulated review lessons.** Read `references/review-learnings.md` first. Apply anything in it that's relevant to this ticket's topic before drafting — this is how feedback from past PR reviews improves future drafts instead of repeating the same correction.

### Research (do all that apply — don't skip straight to drafting)

1. **Source code (ground truth for how it actually works).** Search the primary UI repo (`research.code_repos` in config.yml) for the feature's adapter/handler (`*OpportunityAdapter.tsx`, `*SuggestionAdapter.tsx`), its data hook (`use*Data.ts`), and its `.l10n.ts`/`.I10n.ts` title/description strings. This is the authority for field names, data shape, category, and exact product copy — prefer it over anything else when sources disagree.
2. **Wiki (design intent, specs, decisions).** `mcp__Adobe-Wiki__search_wiki_content` with the feature/opportunity name and the epic/ticket key. Read matching pages (`get_wiki_content`) for: why the feature exists, terminology the product team uses, any documented UX flow or edge cases, and any embedded screenshots that establish what the real UI looks like (informs the media capture spec in step 5, doesn't replace an actual fresh screenshot unless the page is current).
3. **Slack (how the team actually talks about it, open questions, recent changes).** `mcp__Slack__slack_search_messages` with the feature/opportunity name and the ticket key, unrestricted by channel unless `research.slack_channels` narrows it in config.yml. Look for: announcement messages (often has the clean customer-facing framing), design discussion threads, and anything indicating the feature changed recently in a way sibling docs or code comments wouldn't reflect yet.
4. **GitHub PR history (implementation rationale, screenshots, review discussion).** `gh search prs --repo <repo> "<feature name>"` or `gh pr list --repo <repo> --search "<ticket key OR feature name>" --state all` across `research.code_repos`. Read merged PR descriptions for rationale, linked design docs, and screenshots that clarify behavior the code alone doesn't explain (e.g. why a fix type is gated, what an edge case looks like in the UI).
5. **Tone analogs.** Based on the ticket summary, find 2-3 closest existing pages:
   - "... opportunity how-to" tickets -> read 2 sibling files in `help/documentation/opportunities/` (the actual per-opportunity how-to location — `help/opportunity-types/*.md` are the category landing pages with card grids linking to these, not the how-to content itself).
   - Settings/workflow/connection tickets -> read 1-2 sibling files in `help/documentation/` (check `setup/`, `opportunities/`, `settings.md`, `basics.md` for the closest match).
   Mirror heading structure, note-box usage, sentence length, level of technical detail.
6. **Format rules.** Re-read `experience-league-markdown` skill's Quick Reference before writing. Every heading/note/image/link must match its syntax exactly.

### Draft

7. **Target file decision.** Prefer extending an existing page's relevant section over creating a new file, UNLESS the ticket matches the granularity of existing standalone pages (e.g. each opportunity gets its own file under `help/documentation/opportunities/` — a new one follows the exact structure of an existing sibling). When extending an existing page, touch only the one section for this ticket — do not edit unrelated sections even if they look outdated. If a new standalone page, also add its card to the relevant `help/opportunity-types/*.md` landing page (source comment list + generated HTML block, matching the exact pattern of existing cards) and register it in `help/main-toc/TOC.md`.
8. **Draft v1.** Write the content now (in memory / scratch, not yet to the repo file — that happens in Step 6 after the media decision, so a media-pending doc and a media-resolved doc go through the same write path). Synthesize all of steps 1-6 — don't just restate the Jira ticket description.
9. **Iterate.** Re-read the v1 draft against every research finding from steps 1-4: did the draft miss something Slack or Wiki surfaced? Does it contradict what the source code actually does? Does it match sibling tone as closely as it could? Revise before moving on — this is a real second pass, not a formality. Anything still genuinely unconfirmed after this pass (not found in any of the four sources) gets an inline `<!-- CONFIRM -->` comment rather than a guess.
10. **Media decision.** Decide `mediaNeeded: true|false`.
    - `true` if the feature is a multi-step UI workflow where a textual description alone would be materially harder to follow (matches `guidelines.md`'s "used judiciously... when a textual description is insufficient").
    - If `true`, produce: `mediaType` (`screenshot` or `video`), `captureSteps` (exact steps to reproduce the state to capture), `urls` (customer-facing app URL(s) and/or internal page URL(s) needed to reach that state — pull real URLs from the Jira ticket description/comments, Wiki, or `open-aso-devmode-url` conventions if referenced there; never fabricate a URL).
    - If `false`, skip Step 5 for this ticket.

## Step 5 — Media gate

Only runs when Step 4 set `mediaNeeded: true`.

1. Check `{state_dir}/media-requests.json` for an existing entry for this ticket key. If none, this is a fresh request.
2. **Fresh request:**
   - `mcp__Slack__slack_lookup_user` on `media.contacts_in_order[0].email` (sandsinh) to get the Slack user ID.
   - `mcp__Slack__slack_send_dm` with a message containing: the Jira ticket key + link, exactly what to capture (`captureSteps`), the URL(s) to use, and where the answer should go ("reply on the Jira ticket — attach the screenshot directly, or for video, upload via the usual Experience League video form and paste the resulting `video.tv.adobe.com` link as a comment").
   - Write `{state_dir}/media-requests.json[KEY] = {requestedTo: "sandsinh", requestedAt: now, escalated: false}`.
3. **Existing request:** compare `now - requestedAt` (or `escalatedAt` if already escalated) against `media.escalate_after_hours` / `media.give_up_after_hours`:
   - Not yet elapsed -> do nothing this run, proceed to publish with media still pending (draft PR).
   - Elapsed escalate threshold, not yet escalated -> DM `media.contacts_in_order[1]` (kanishka), message notes sandsinh was already asked N hours ago with no response. Update entry: `escalated: true, escalatedAt: now`.
   - Elapsed give-up threshold -> set `mediaNeeded: false` for publishing purposes, insert an inline note in the draft: `>[!TIP]\n>\n>A screenshot for this step is being added in a follow-up update.` Mark entry `gaveUp: true`.

## Step 6 — Publish

Skip if the ticket was fully skipped in Step 3 (nothing to publish).

1. `git checkout -b {github.branch_prefix}<KEY>-<short-slug>` from the default branch (fetch+reset first if the default branch has moved).
2. Write the Step 4 draft to the target file decided in Step 4.3. Re-verify against `experience-league-markdown`'s "Before Committing Markdown Changes" checklist line by line.
3. If a markdown linter is configured (`markdownlint_custom.json` at repo root) and `markdownlint-cli`/`npx markdownlint` is available, run it against the changed file(s) and fix any violations before committing.
4. Commit: `docs(aso): <ticket summary, lowercase, no trailing period>\n\nSITES-XXXXX`.
5. `git push -u origin <branch>`.
6. Reviewer selection: `gh pr list --repo {github.repo} --label {github.pr_label} --state open --json reviewRequests` — count how many currently list each of the two configured reviewers; assign whichever has fewer (tie -> `sandsinh_adobe`).
7. PR body:
   ```
   ## Summary
   [1-2 sentence description of the feature now documented]

   ## Source
   Closes documentation gap tracked in [SITES-XXXXX](https://jira.corp.adobe.com/browse/SITES-XXXXX)

   ## Media
   [either "No media needed for this update." OR "Screenshot/video requested from {contact} on {date} — PR opened as draft until resolved." OR "Media follow-up pending — shipped without it; see inline note."]

   > 🤖 Drafted by aso-doc-agent
   ```
8. `gh pr create --repo {github.repo} --title "<ticket summary>" --body "<above>" --label {github.pr_label} --reviewer <chosen-github-handle> --draft` if media is still pending, else omit `--draft`.
9. `gh pr edit <number> --add-label {github.pr_label}` if the label flag didn't take (belt and suspenders, matches the pattern used elsewhere in this org's tooling).
10. Jira: `add_jira_comment` linking the PR URL. Do not transition ticket status — leave that to the docs team's own triage; the `{jira.picked_label}` label is the only status signal this agent writes.

## Step 7 — Run summary

1. Update `{state_dir}/run-state.json`: `runs_completed += 1`, timestamp, ticket picked (or "none" + reason), PR opened/updated (or "none" + reason), cap status.
2. Print a short human-readable summary (ticket, action taken, PR link, media status).
