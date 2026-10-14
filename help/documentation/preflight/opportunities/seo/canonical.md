---
title: Preflight Canonical Audit
description: Learn about the Canonical audit in Preflight for AEM Sites Optimizer.
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
---
# Canonical audit

The **Canonical** audit reviews the canonical link on your page. The canonical link is a `<link rel="canonical">` tag in the page's `<head>` that names the preferred URL for the page's content. The audit flags canonical links that are missing, set up incorrectly, or that point somewhere other than the page itself.

## Why it matters

The same content can often be reached at more than one URL, for example with and without a trailing slash, with tracking parameters, or with different capitalization. Search engines treat each URL as a separate page unless told otherwise. The canonical link tells them which URL you prefer; this helps them group the duplicates, combine ranking signals such as inbound links on one URL, and show that URL in search results.

A canonical link that is wrong can be worse than none at all. Search engines can ignore a canonical link they can't trust, such as one with no URL, one placed outside the `<head>`, or one of several tags that disagree. A canonical link that points to a different page asks search engines to show that page in place of yours, which can keep your page out of search results.

## What the audit checks

The audit checks for problems in three areas:

* **Whether the page has one canonical link:** the canonical link is missing, or the page has more than one. Several canonical links that point to different URLs are reported separately, because search engines may ignore all of them.
* **Whether the tag is set up correctly:** the tag is outside the `<head>`, has no `href` attribute or an empty one, or carries an attribute such as `hreflang`, `media`, or `type` that can cause search engines to ignore it.
* **Whether the URL is correct:** the canonical URL is relative instead of absolute, contains uppercase letters in the path or query string, uses a different protocol (`http://` or `https://`) from the page, or points to a different page from the one you are editing.

## How the canonical URL is compared

Preflight runs on preview pages, whose host is usually different from your production site. To avoid flagging every preview page, the audit doesn't compare the host of the canonical URL with the host of the page. When it checks whether the canonical link points to the page itself, it compares only the path of the URL, so `https://www.example.com/products/shoes` matches the preview page `/products/shoes`. A trailing slash and letter case in the path don't count as differences for this check.

## Known limitations

* **Different domain:** a canonical URL that points to a different site isn't flagged by Preflight, because preview hosts always differ from the production site. Confirm that the domain in the canonical URL is the one you expect.
* **HTTP `Link` header:** Preflight checks only the canonical tag, not the HTTP `Link` header. A page that sets its canonical URL only in the header is reported as missing the canonical link.

## How to resolve

When the audit finds opportunities, each one describes the problem and the recommended change. In most cases the page should have exactly one canonical link, in the `<head>`, with an absolute URL with a lowercase path that points to the page itself. If the page intentionally points to another page as its canonical version, for example a duplicate or printer-friendly copy, you can leave it as is. The audit will still report it. To learn how to review and resolve opportunities, see [Audit results in Preflight](../../audit-results.md).
