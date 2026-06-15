---
title: Release Notes Writing Guidelines
description: Internal guide for writing customer-facing AEM Sites Optimizer release notes.
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
topic_v2:
  - id: cdd65e7e-8839-44a2-bc21-0e03623b5dd1
    internal-label: Optimization
---

# Release Notes Writing Guidelines

This document defines how to write customer-facing release notes for Adobe Experience Manager Sites Optimizer. These guidelines are used by the `/release-notes` Claude Code skill and should be followed when writing or reviewing release notes manually.

## Core Principles

1. **Customer benefit first.** Every entry should answer "what can I do now that I couldn't before, or do better?" — not "what did we ship?" Lead with the value, not the implementation.

2. **Leadership tone.** Write for a decision-maker: outcomes and capabilities, not technical mechanics. A VP of Digital Experience should immediately understand why an update matters.

3. **No internal jargon.** Replace all team-internal shorthand:
   - "PLG" → "trial users" or "new customers"
   - "BackOffice" → omit entirely (infrastructure-only change)
   - "MSM" → "AEM Multi-Site Manager"
   - "SHM" → "Site Health Monitor"
   - "OrcaFix", "Cursor commands", "AGENTS.md" → omit entirely
   - "EDS" → "Edge Delivery Services"

4. **Short entries.** One sentence of *what*, one sentence of *why it matters*. If both fit in one sentence, do that.

5. **Accurate scope.** Only include changes a customer will see in the product UI or experience in their workflows. Infrastructure, tooling, and developer-experience changes are excluded.

## Page Structure Template

Each release entry follows this structure:

```markdown
## [Month Start]–[Day End], [Year]

### New Features

- **[Feature Name]** — [One-sentence benefit statement. One sentence of business context if needed.]

### Enhancements

- **[Enhancement Name]** — [One-sentence improvement statement.]

### Bug Fixes

- [Short description of what was fixed and why it matters to users.]
```

**Rules:**
- Date range format: `May 11–22, 2026` (en-dash, abbreviated month, four-digit year).
- Reverse-chronological order: newest release at the top of the page.
- Only include sections that have content. Omit "Enhancements" or "Bug Fixes" if empty.
- Bug Fixes entries do not use bold feature names — they are plain bullets.
- Only include Bug Fixes if there are 3 or more user-visible fixes worth noting.

## What to Include vs. Exclude

### Include

| Category | Examples |
|---|---|
| New opportunity types | Ad Intent Mismatch, No CTA Above the Fold |
| New views or workflows | Deployed tab, CSV export, Jira linking |
| Trial / onboarding improvements | Guided setup flow, no-site-onboarded state |
| Settings improvements | Audit Target URLs, Delivery Type configuration |
| Meaningful UX fixes | Incorrect counts, broken navigation, display issues affecting decisions |
| New data/integrations | Ahrefs data in Organic Search, dependency tree in Security |
| Deploy-to-author capabilities | New opportunity types that support direct deployment |

### Exclude

| Category | Why |
|---|---|
| AI tooling (OrcaFix, Cursor commands, AGENTS.md, Claude Code rules) | Internal developer tooling, not visible to customers |
| Localization linter / pre-commit hooks | Engineering process, not a product feature |
| BackOffice / infrastructure changes | Not visible in the UI unless they change end-user behavior |
| React Spectrum version upgrades | Internal dependency, not user-visible |
| E2E test improvements | Engineering quality, not a product feature |
| Release pipeline automation | Internal process |
| SitesInternal-only features | Not available to customers |

## Tone Examples

| Internal phrasing | Customer-facing phrasing |
|---|---|
| "Introduced REJECTED state for manual validation workflow" | "You can now mark suggestions as rejected to indicate they do not apply to your site, keeping your opportunity list focused on actionable items." |
| "Deployed View for Canonical & Hreflang opportunities (grouped by date)" | "Changes to Canonical and Hreflang opportunities are now grouped by deployment date in a Deployed tab, giving you a clear history of what was fixed and when." |
| "Alt Text Autofix V2 — 'Check fixability' pre-flight assessment" | "Before deploying an Alt Text fix, you can run a pre-flight check to verify the fix can be successfully applied to your content." |
| "96% storage optimization for SHM metrics" | omit — infrastructure only |
| "AGENTS.md with formal agent roles and safety guardrails" | omit — internal AI tooling |
| "E2E test performance optimizations (~6min → ~5min)" | omit — engineering process |

## Grouping Rules

- **Group by capability area**, not by team or repository. For example, all Alt Text improvements (features, enhancements, and fixes) belong in the same area — do not scatter them across sections.
- **Consolidate closely related fixes** into a single bullet rather than listing each one separately (e.g., "Multiple display and layout improvements across the Paid Traffic, Accessibility, and Security opportunities").
- **Threshold for Bug Fixes section**: only include this section when there are 3 or more user-visible fixes worth calling out. Trivial or purely cosmetic fixes below this threshold should be omitted.
