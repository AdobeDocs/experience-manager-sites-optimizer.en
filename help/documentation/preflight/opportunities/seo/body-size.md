---
title: Preflight Body Size Audit
description: Learn about the Body size audit in Preflight for AEM Sites Optimizer.
---
# Body size audit

The **Body size** audit reviews the amount of body content on your page. Pages with very little content can be less useful to readers and may rank poorly in search results. The audit flags pages that appear to have too little text.

## Why it matters

Search engines and AI assistants rely on a page's text to understand what it is about. A page with little or no readable text is often treated as low value, which can hurt how it ranks and whether it is surfaced in AI answers.

## What the audit checks

The audit measures the amount of authored text on the page and reports two situations:

- **No text content:** the page was read successfully but has no body text at all, for example a page that is only an image.
- **Thin content:** the page has some text, but less than the recommended minimum.

A page with enough text passes and is not flagged.

## How your content is measured

The audit measures the text in your page's main content area, not the whole page. Shared elements like navigation, headers, footers, and breadcrumbs repeat on every page, so counting them would mean no templated page ever looked thin. Only your authored content is measured.

To find your content, the audit uses the first of these that applies:

1. **A `<main>` element (or `role="main"`).** This is treated as the definitive content area, and only the text inside it is measured. It is the most reliable option, and if a template splits content across several `<main>` elements, their text is added together.
2. **The page body, with chrome removed.** If there is no `<main>`, the audit measures the `<body>` after removing recognized page chrome: navigation and the page-level header and footer, whether marked with standard HTML tags, ARIA landmark roles, or the standard AEM header, footer, and navigation components. A header or footer that belongs to a section of content, such as an article's own title or byline, is kept.
3. **The whole page body.** If there is no content landmark and no recognized chrome, the entire `<body>` is measured.

A couple of things never count toward the total: text inside images and links (so a page made up mostly of images can still be flagged), and text inside `<script>` and `<style>` tags (so analytics or data-layer scripts do not inflate the measurement).

## Making sure your content is measured correctly

If a page is flagged as thin but you believe it has adequate content, the most common cause is that the audit couldn't cleanly separate your content from the page chrome. To get the most accurate measurement:

- **Wrap your authored content in a `<main>` element** (or add `role="main"`). This is the single most effective step. It removes all ambiguity and guarantees only your content is measured.
- **Use standard header/footer markup** (`<header>`, `<footer>`) or the standard AEM header/footer Experience Fragment variations, so the audit reliably recognizes and excludes them.
- **Mark section-level headers and footers inside `<article>`/`<section>`/`<aside>`**, so content that lives in those headers/footers is correctly kept.

## Known limitations

The audit relies on your page's markup to distinguish content from chrome. On a page that has **no `<main>`, no standard landmark markup, and header/footer components named differently from the platform conventions**, some chrome text may be included in the measurement, or authored text may occasionally be excluded. Adding a `<main>` element around your content resolves every such case. The audit does not attempt to guess the content region from text density or visual layout; it relies on markup signals so that results are predictable and repeatable.

## How to resolve

When the audit finds opportunities, each one describes the problem and the recommended change. To learn how to review and resolve opportunities, see [Audit results in Preflight](../../audit-results.md).
