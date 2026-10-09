---
title: Preflight Internal Links Audit
description: Learn about the Internal Links audit in Preflight for AEM Sites Optimizer.
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
---
# Internal Links audit

The **Internal Links** audit reviews the links on your page that point back to your own site. The audit checks each internal link from the page you are editing and flags the ones that are broken, insecure, or pointed somewhere a visitor cannot follow.

## Why it matters

A broken internal link is a dead end for the reader and a wasted crawl for a search engine, which passes no value on to the page it was meant to reach. Internal links are also the easiest kind to break by accident: a page gets moved or renamed, and every link to it silently stops working. Because the links are all on your own site, they are also the ones you can fix yourself.

## What the audit checks

The audit reports an opportunity for each internal link that has one of the following problems:

* **Broken link:** the link returns an error, such as `Status 404` or `Status 500`. A link that reaches the error after a redirect is reported the same way.
* **Insecure link:** the link uses `http://` instead of `https://`. When the secure version of the same URL works, Preflight offers it as the suggestion.
* **Editor URL:** the link points at an AEM editor URL instead of the content page. The link works for you while you are authoring, which is what makes it easy to miss, but every visitor lands on the authoring interface. Preflight suggests the content URL.
* **Missing fragment:** the link points at an anchor, such as `#pricing`, that the target page does not have. The page still opens, but the reader arrives at the top of it instead of the section you meant, so this is reported at a lower impact than a broken link. If the page has the same anchor capitalized differently, Preflight suggests the corrected anchor. If the target page itself is broken, it is reported as a **Broken link** instead.
* **Unverified link:** the check timed out or hit a network error. Preflight cannot tell whether the link works, so it asks you to check the link yourself rather than reporting it as broken.

A link that resolves successfully is not flagged, even when it has multiple redirects on the way. Neither is a link that redirects to a different site, because it is no longer an internal link.

## How the links are checked

The audit checks links from your authoring session, so it sees them the way you are signed in to see them. A page that exists only on the author instance resolves correctly instead of looking broken.

Links that AEM's link checker has already marked as invalid are included in the audit, even though the editor removes the clickable link from the page. They are then rechecked rather than taken on trust, so a link that has since started working is not reported.

One opportunity is reported for every place a link appears, so a bad link used in three spots gives you three instances to fix, each highlighting its own spot on the page. When one of those spots has more than one problem, Preflight shows them together on one card.

## Known limitations

The audit runs in the AEM Sites Page Editor, in Adobe Managed Services (AMS), and in document-based authoring through the Sidekick. It is not currently available in the Universal Editor.

## How to resolve

When the audit finds opportunities, each one describes the problem and the recommended change, and identifies the link involved. Use **Highlight on page** to jump to the link in your content, and use the **Current URL** section to copy the URL or open it in a new tab so you can confirm the problem for yourself. To learn how to review and resolve opportunities, see [Audit results in Preflight](../../audit-results.md).
