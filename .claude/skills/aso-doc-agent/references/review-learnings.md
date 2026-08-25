# ASO Doc Agent — Review Learnings

Durable lessons extracted from human PR review feedback on this agent's own PRs. Read
this file at the start of Step 4 (Research + draft) in `pipeline.md`, before drafting
anything — the point is that a correction a reviewer makes once should not need to be
made again on a future ticket.

## What belongs here

Only **generalizable** feedback — a pattern that will recur on future tickets, about
tone, structure, missing sections, wrong file placement, or content accuracy. Examples:

- "Always mention the Ignored tab for opportunities that support ignore/skip."
- "Don't assert Ultimate-tier gating unless the ticket or an existing sibling page confirms it — leave it commented out and flag as an open item instead."
- "New opportunity how-to pages need a TOC.md entry and a card-grid entry on their opportunity-types landing page, not just the page itself."

## What does NOT belong here

One-off, mechanical feedback that only applied to a single PR: typos, a broken link, a
missing comma, a wrong file path in that specific PR. Fix those directly in the PR — they
don't generalize to future drafts, so a durable entry would just be noise.

## Entry format

```markdown
## YYYY-MM-DD — SITES-XXXXX (PR #NN)

**Lesson:** [one or two sentences — the generalizable rule]

**Why:** [what the reviewer actually said, or the specific mistake it corrects]

**Applies to:** [which ticket types / pages this affects — "all opportunity how-to pages", "settings/setup pages", "everything", etc.]
```

Newest entries at the top. If a later lesson supersedes or narrows an earlier one, edit
the earlier entry to note that rather than leaving two conflicting rules in the file.

---

No entries yet — this file gets its first entry the first time a human requests changes
on one of this agent's PRs.
