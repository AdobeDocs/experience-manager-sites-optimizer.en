---
title: Preflight Body Size Audit
description: Learn about the Body size audit in Preflight for AEM Sites Optimizer.
---
# Body size audit

The **Body size** audit reviews the amount of body content on your page. Pages with very little content can be less useful to readers and may rank poorly in search results. The audit flags pages that appear to have too little text.

## Why it matters

Search engines and AI assistants rely on a page's text to understand what it is about. A page with little or no text is often treated as low value, which can hurt how it ranks and whether it is surfaced in AI answers.

## What the audit checks

The audit measures the amount of authored text on the page and reports two situations:

* **No text content:** the page was read successfully but has no body text at all, for example a page that is only an image.
* **Thin content:** the page has some text, but less than the recommended minimum.

A page with enough text passes and is not flagged.

## How your content is measured

The audit measures the text in your page's main content area, not the whole page. Shared elements like navigation, headers, footers, and breadcrumbs repeat on every page, and the audit excludes them where it can recognize them so that this shared chrome does not mask genuinely thin content. How completely it can separate your content from that chrome depends on your page's markup, as described below.

To find your content, the audit uses the first of these that applies:

1. **`<main>` elements (or `role="main"`).** This is treated as the definitive content area, and only the text inside it is measured (if a page has more than one such element, their text is combined). It is the most reliable option.
1. **The page body, with chrome removed.** If there is no `<main>` and no `role="main"`, the audit measures the `<body>` after removing recognized page chrome: navigation and the page-level header and footer, whether marked with standard HTML tags, ARIA landmark roles, or the standard AEM header, footer, breadcrumb, and navigation components. A header or footer that belongs to a section of content, such as an article's own title or byline, is kept.
1. **The whole page body.** If there is no content landmark and no recognized chrome, the entire `<body>` is measured.

A few notes on what counts. Images do not contribute any text (their `alt` text is not measured), so a page that is mostly images can still be flagged. Text inside `<script>` and `<style>` tags is never counted, so analytics or data-layer scripts do not inflate the measurement. Ordinary link text, however, is counted like any other text in your content.

## If a flagged page looks correct to you

If a page is flagged as thin but you are confident it has enough content, the audit may not have cleanly separated your content from the surrounding chrome, such as navigation, headers, and footers.

If you would like the audit to measure your page more precisely, the following markup choices help it:

* The most reliable option is to wrap your authored content in a `<main>` element (or add `role="main"`). This removes any ambiguity, so only your content is measured.
* If you cannot add a `<main>`, standard header and footer markup (`<header>`, `<footer>`) or the standard AEM header and footer Experience Fragment variations help the audit recognize and exclude your page chrome.
* Marking section-level headers and footers inside `<article>`, `<section>`, or `<aside>` keeps content that lives in those headers and footers from being dropped.

## Known limitations

The audit relies on your page's markup to distinguish content from chrome. On a page that has **no `<main>`, no standard landmark markup, and header/footer components named differently from the platform conventions**, some chrome text may be included in the measurement, or authored text may occasionally be excluded. Adding a `<main>` element around your content resolves every such case. The audit does not attempt to guess the content region from text density or visual layout; it relies on markup signals so that results are predictable and repeatable.

## How to resolve

When the audit finds opportunities, each one describes the problem and the recommended change. To learn how to review and resolve opportunities, see [Audit results in Preflight](../../audit-results.md).
