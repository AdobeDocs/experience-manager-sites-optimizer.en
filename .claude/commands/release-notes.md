---
description: Convert internal ASO sprint release notes to customer-facing Experience League format and append to the release notes page.
---

# Release Notes Converter

Converts internal sprint release notes (from the Slack `#aem-sites-optimizer-announcements` channel or the `.cursor/commands/release-notes` Cursor output) into a customer-facing entry and appends it to `help/documentation/release-notes.md`.

## Usage

Invoke this skill, then paste the internal release notes content when prompted. The skill will:

1. Read `help/documentation/release-notes-guidelines.md` for filtering and tone rules.
2. Parse the internal release notes (emoji-categorized sections: ✨ Features, 🚀 Enhancements, 🤖 AI-First, 🔧 Fixes, 🏢 BackOffice).
3. Filter out all excluded categories per guidelines (AI tooling, BackOffice, localization linter, E2E tests, SitesInternal-only items).
4. Rewrite remaining items in customer-facing tone using the guidelines' tone examples as a reference.
5. Group related items by capability area (not by team or repo).
6. Format as a new release entry following the page structure template in the guidelines.
7. Prepend the new entry to `help/documentation/release-notes.md` (above the previous latest entry, below the page intro paragraph).
8. Print a summary table showing: items kept, items rewritten, items dropped (with reason for each dropped item).

## Steps

1. Read `help/documentation/release-notes-guidelines.md` — internalize all principles, include/exclude rules, tone examples, and grouping rules.
2. Ask the user for the date range covered (e.g., "May 11–22, 2026") if not already provided.
3. Ask the user to paste the internal release notes content (or accept a file path).
4. Process the content:
   - **Parse** each section (✨/🚀/🤖/🔧/🏢) and its bullet points.
   - **Filter** per the Exclude table in the guidelines. Mark each dropped item with a reason.
   - **Rewrite** kept items in customer tone: benefit-first, no jargon, short entries.
   - **Group** by capability area where multiple items are related.
   - **Threshold check**: only include a "Bug Fixes" section if there are 3+ user-visible fixes.
5. Format the new entry using the page structure template from the guidelines.
6. Read the current content of `help/documentation/release-notes.md`.
7. Insert the new entry immediately after the page intro paragraph (before the previous latest `##` date heading).
8. Write the updated file.
9. Print the summary table.

## Input Format

The skill accepts the internal release notes in the standard team format:

```
*ASO UI Release Notes — [Date Range]*
Collaborators: [teams]

✨ *Features*
• [Feature description]

🚀 *Enhancements*
• [Enhancement description]

🤖 *AI-First Development*
• [AI tooling items — will be dropped]

🔧 *Fixes & UX Improvements*
• [Fix description]

🏢 *BackOffice*
• [BackOffice items — will be dropped]
```

## Output

The skill outputs:

1. The formatted customer-facing entry (for review before writing).
2. A confirmation prompt before modifying `release-notes.md`.
3. After writing: a summary table of kept / rewritten / dropped items.
