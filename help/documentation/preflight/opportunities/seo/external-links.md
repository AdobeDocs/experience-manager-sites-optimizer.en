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

* **Broken link:** the link returns `Status 404` or `Status 410`, or its site cannot be reached at all, for example because the domain no longer exists. A link that reaches the error after a redirect is reported the same way.
* **Insecure link:** the link uses `http://` and the site does not redirect it to `https://`. A link that starts as `http://` but is redirected to a secure `https://` page is not flagged. Update the link to use `https://`.
* **Unverified link:** Preflight could not confirm that the link works, for example because the site requires sign-in, blocks automated checks, keeps returning a server error, does not respond in time, or redirects too many times. Some social networks, such as LinkedIn and Instagram, report pages that exist as missing to automated checks, so missing-page errors from those sites are also reported as unverified. These links very likely work in a browser, so Preflight does not report them as broken. Instead, it asks you to open the link and confirm it yourself, and reports it at a low impact.

A link can be both insecure and broken, or both insecure and unverified, in which case both opportunities are reported. A link that resolves successfully is not flagged, even when it has redirects on the way.

## Which links are checked

Every external link on the page is checked. An external link is any link whose host differs from the page you are editing. The host is the domain name plus any non-standard port, such as `:8443`. Subdomains count as different hosts, so `blog.example.com` and `example.com` are both external to `www.example.com`. Links to the same host, including `http://` links to your own site, are covered by the [Internal Links](./internal-links.md) audit instead. Links in site navigation are always included, because the **Show site navigation links** setting applies only to the Internal Links audit. Links such as `mailto:`, `tel:`, and `javascript:` are ignored.

Each link is reported once, even if it appears several times on the page or with different anchors, such as `#pricing` and `#features`. The opportunity highlights the first place the link appears.

Links that AEM's link checker has already marked as invalid are included in the audit, even though the editor removes the clickable link from the page. They are rechecked rather than taken on trust, so a link that has since started working is not reported.

## Known limitations

* **Private addresses:** links to private or internal network addresses, such as an intranet site, are not checked and are not reported.
* **Server-side view:** Preflight checks external links from Adobe's servers rather than from your browser. A site that behaves differently based on location, sign-in, or bot detection may return a different result than you see in your browser. Such links are usually reported as **Unverified link** rather than broken.

## How to resolve

When the audit finds opportunities, each one describes the problem and the recommended change, and identifies the link involved. Use **Highlight on page** to jump to the link in your content, and open the URL in a new tab to confirm the problem for yourself. For a broken link, update it to the page's new location or remove it. For an unverified link, confirm it opens correctly in your browser. To learn how to review and resolve opportunities, see [Audit results in Preflight](../../audit-results.md).
