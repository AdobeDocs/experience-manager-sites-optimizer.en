---
title: Preflight External Links Audit
description: Learn about the External Links audit in Preflight for AEM Sites Optimizer.
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
---
# External Links audit

The **External Links** audit reviews the links on your page that point to other sites. The audit checks each external link from the page you are editing and flags the ones that are broken, insecure, or that could not be verified automatically.

## Why it matters

A broken external link is a dead end for the reader and a signal to search engines that the page is not well maintained. External links are also the ones you have the least control over: the other site can move, rename, or remove a page at any time, and your link silently stops working. Checking them before you publish catches the links that have gone stale since they were first added.

## What the audit checks

The audit reports an opportunity for each external link that has one of the following problems:

* **Broken link:** the link cannot be reached, or it returns an error such as `Status 404`, `Status 410`, or a `5xx` server error. A link that reaches the error after a redirect is reported the same way. A link whose site does not respond at all, for example because the domain no longer exists, is also reported as broken.
* **Insecure link:** the link uses `http://` and the site does not redirect it to `https://`. A link that starts as `http://` but is redirected to a secure `https://` page is not flagged. Update the link to use `https://`.
* **Unverified link:** the site answered but refused the automated check, for example because it requires sign-in (`Status 401` or `Status 403`), limits automated requests (`Status 429`), or blocks bots, as some social networks do. A link that redirects too many times to follow is also reported this way. These links very likely work in a browser, so Preflight does not report them as broken. Instead, it asks you to open the link and confirm it yourself, and reports it at a low impact.

A link can be both insecure and broken, or both insecure and unverified, in which case both opportunities are reported. A link that resolves successfully is not flagged, even when it has redirects on the way.

## How the links are checked

An external link is any link whose host differs from the page you are editing. The host is the domain name plus any non-standard port, such as `:8443`. Subdomains count as different hosts, so `blog.example.com` and `example.com` are both external to `www.example.com`. Whether the link uses `http://` or `https://` does not matter. Links to the same host, including `http://` links to your own site, are covered by the [Internal Links](./internal-links.md) audit instead. Links such as `mailto:`, `tel:`, and `javascript:` are ignored.

Your browser cannot read the status of a link on another site, so Preflight checks external links from Adobe's servers rather than from your authoring session. Each link is checked once, even if it appears several times on the page or with different anchors, such as `#pricing` and `#features`. The opportunity highlights the first place the link appears.

Links that AEM's link checker has already marked as invalid are included in the audit, even though the editor removes the clickable link from the page. They are then rechecked rather than taken on trust, so a link that has since started working is not reported.

## Known limitations

* **Number of links:** up to 50 distinct external links are checked per page. Links beyond that limit are not checked.
* **Time limit:** each link has a 10-second timeout, and the whole check has a time limit so that Preflight stays responsive. A site that does not respond within the timeout is reported as broken. On pages with many slow sites, some links may not be checked in a given run.
* **Private addresses:** links that resolve to private or internal network addresses, such as an intranet site, are not checked and are not reported.
* **Server-side view:** because links are checked from Adobe's servers, a site that behaves differently based on location, sign-in, or bot detection may return a different result than you see in your browser. Such links are usually reported as **Unverified link** rather than broken.

## How to resolve

When the audit finds opportunities, each one describes the problem and the recommended change, and identifies the link involved. Use **Highlight on page** to jump to the link in your content, and open the URL in a new tab to confirm the problem for yourself. For a broken link, update it to the page's new location or remove it. For an unverified link, confirm it opens correctly in your browser. To learn how to review and resolve opportunities, see [Audit results in Preflight](../../audit-results.md).
