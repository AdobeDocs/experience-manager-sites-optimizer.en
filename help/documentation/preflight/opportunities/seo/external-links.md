---
title: Preflight External Links Audit
description: Learn about the External Links audit in Preflight for AEM Sites Optimizer.
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
---
# External Links audit

The **External Links** audit reviews the links on your page that point to other sites. The audit checks each external link from the page you are editing and flags the ones that are broken, insecure, or could not be verified automatically.

## Why it matters

A broken external link is a dead end for the reader and a signal to search engines that the page is not well maintained. External links are also the ones you have the least control over: the other site can move, rename, or remove a page at any time, and your link silently stops working. Checking them before you publish catches the links that have gone stale since they were first added.

## What the audit checks

The audit sorts problems into three groups:

* **Broken:** the link fails for every visitor right now and is not expected to recover.
* **Unverified:** the link fails for some visitors, may fail only temporarily, or could not be checked.
* **Best practice:** the link works, but it should not be authored that way, such as an insecure `http://` link.

The audit reports an opportunity for each external link that has one of the following problems:

* **Broken link:** the link does not work for anyone who opens it. Preflight reports a link as broken when:
  * its site cannot be reached at all, for example because the domain no longer exists.
  * it returns `Status 404` or `Status 410`.
  * it returns `Status 405`, meaning the site rejects normal page requests.
  * it redirects in a loop or more than 20 times. Browsers use the same limit and show a "too many redirects" error.

  A link that reaches one of these errors after a redirect is reported the same way.
* **Insecure link:** the link uses `http://` and Preflight did not see it redirect to `https://`, including when the site did not respond. A link that starts as `http://` but is redirected to a secure `https://` page is not flagged. Update the link to use `https://`.
* **Unverified link:** Preflight could not confirm whether the link works, so it asks you to open the link and check it yourself. The opportunity explains which case applies:
  * **Requires sign-in:** the link returns `Status 401`. Visitors without an account cannot open it, so confirm that this is intended.
  * **Blocks automated checks:** the link returns `Status 403` or `Status 429`, or the site blocks automated requests in another way, as LinkedIn does. Confirm that the link opens in a browser.
  * **Social and sign-in-walled sites:** LinkedIn, Instagram, Facebook, X (Twitter), TikTok, and Threads return misleading errors to anonymous requests, so a `Status 404`, `Status 410`, `Status 405`, or redirect loop from these sites is reported as unverified rather than broken.
  * **Server error:** the link returns a server error (`Status 5xx`) that persists when Preflight checks it again. Preflight retries once before reporting it. The error may be temporary, so confirm the link works before you publish.
  * **Unavailable for legal reasons:** the link returns `Status 451` in the region Preflight checks from. Confirm that it works for your audience.
  * **No response in time:** the site did not respond in time, even after Preflight retried once. The site may be slow or temporarily down.

A link can be both insecure and broken, or both insecure and unverified, in which case both opportunities are reported. A redirect chain alone is not flagged if it reaches a working page within 20 redirects.

## Which links are checked

Every external link on the page is checked. An external link is any link whose host differs from the page you are editing. The host is the domain name plus any non-standard port, such as `:8443`. Subdomains count as different hosts, so `blog.example.com` and `example.com` are both external to `www.example.com`. Links to the same host, including `http://` links to your own site, are covered by the [Internal Links](./internal-links.md) audit instead. Links in site navigation are always included, because the **Show site navigation links** setting applies only to the Internal Links audit. Links such as `mailto:`, `tel:`, and `javascript:` are ignored.

Each link is reported once, even if it appears several times on the page or with different anchors, such as `#pricing` and `#features`. The opportunity highlights the first place the link appears.

Links that AEM's link checker has already marked as invalid are included in the audit, even though the editor removes the clickable link from the page. They are rechecked rather than taken on trust, so a link that has since started working is not reported.

## Filter the results

On the detail page, use the filter beside the **Instances** heading to show only some of the opportunities:

| Filter | Opportunities shown |
|---|---|
| **All** (default) | Every opportunity |
| **Broken** | Broken links |
| **Needs verification** | Unverified links and insecure links |

If a link has more than one opportunity, such as an insecure link that is also broken, each opportunity appears under its own filter. For more information, see [Filter instances](../../audit-results.md#filter-instances).

## Known limitations

* **Private addresses:** links to private or internal network addresses, such as an intranet site, are not checked and are not reported.
* **Time limits:** each link has its own time limit, so a slow site does not prevent other links from being checked. Every link on the page gets a result. A link that does not respond in time, even after one retry, is reported as **Unverified link** rather than broken.
* **Excluded domains:** your site's configuration can exclude specific domains from checking. Links to an excluded domain, or to any of its subdomains, are not checked and are not reported.
* **Server-side view:** Preflight checks external links from Adobe's servers rather than from your browser. A site that behaves differently based on location, sign-in, or bot detection may return a different result than you see in your browser. Such links are usually reported as **Unverified link** rather than broken.

## How to resolve

When the audit finds opportunities, each one describes the problem and the recommended change, and identifies the link involved. Use **Highlight on page** to jump to the link in your content, and open the URL in a new tab to confirm the problem for yourself. Then act on the opportunity:

* **Broken link:** update the link to the page's new location, or replace or remove it. For a redirect loop, contact the other site's owner or link to a different source.
* **Insecure link:** change the link to use `https://`, after confirming that the secure version works.
* **Unverified link:** open the link in your browser and confirm it shows the expected page. For a link that requires sign-in, confirm that your readers are expected to have an account. For a server error, check the link again before you publish. If the link does not work, treat it as broken.

To learn how to review and resolve opportunities, see [Audit results in Preflight](../../audit-results.md).
