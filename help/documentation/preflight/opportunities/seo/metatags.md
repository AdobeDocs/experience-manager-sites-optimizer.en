---
title: Preflight Metatags Audit
description: Learn about the Metatags audit in Preflight for AEM Sites Optimizer.
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
---
# Metatags audit

The **Metatags** audit reviews the page title, the meta description, and the main (H1) heading. It flags any of them that are missing, empty, or outside the recommended length, and flags pages with more than one H1 heading.

## Why it matters

The page title and meta description are usually what people see for your page in search results: the title as the clickable headline, and the description as the summary below it. A missing or poorly sized title or description can be cut off or replaced with text the search engine picks from your page. The H1 heading tells readers and search engines what the page is mainly about, so a page should have one clear H1.

## What the audit checks

The audit reports an opportunity for each of the following problems:

* **Page title:** missing, empty, too short, or longer than the ideal length.
* **Meta description:** missing, empty, too short, or longer than the ideal length.
* **H1 heading:** missing, empty, longer than the ideal length, or more than one H1 on the page.

A value a few characters over the ideal length is reported as **above ideal length**, and one past the audit's maximum as **too long**. Preflight has no too-long threshold for page titles.

| Tag | Ideal length | Above ideal length | Too long |
|---|---|---|---|
| Page title | 40 to 60 characters | More than 60 characters | – |
| Meta description | 140 to 160 characters | 161 to 175 characters | More than 175 characters |
| H1 heading | Up to 70 characters | 71 to 75 characters | More than 75 characters |

These ranges are recommended guidelines, not search engine requirements. Preflight uses them to decide when to report an opportunity.

## How the values are read

The audit reads the page you are editing: the text of the `<title>` element, the content of the `<meta name="description">` tag, and the visible text of the first `<h1>` element, including any bold or italic text inside it.

A tag is **missing** when the page doesn't have it, and **empty** when it's there but has no visible text. Lengths count every character, including spaces and punctuation. Only the first H1 is checked for length. When a page has more than one H1, each one is listed as a separate instance, so you can find and change the extra headings.

## Suggestions

Every opportunity includes a recommendation, such as the ideal length for the tag or one H1 on a page.

Page title, meta description, and H1 opportunities can also include an AI-generated suggestion, written from your page's own content. A suggestion is shown only if it fits the ideal length. Review and edit every suggestion before you use it.

When an H1 opportunity has no AI suggestion, its suggestion is fixed advice instead, such as shortening the heading or changing extra H1 headings to H2. When a page title or meta description opportunity has no AI suggestion, Preflight shows that no suggestions are available.

## If a flagged value looks correct to you

On Edge Delivery Services pages, a page title or meta description you haven't set is filled in automatically from the page's first heading and first paragraph. These are often shorter than the ideal length, so the page is flagged. Setting your own title and description in the page metadata resolves this.

## Known limitations

* **Other head tags aren't checked,** such as Open Graph tags for social sharing or the robots tag.
* **Length is counted in characters:** search engines shorten titles and descriptions based on how much space they take up on screen, so a value within the ideal length can still be shortened in search results.
* **Languages without spaces between words:** on pages in languages such as Chinese, Japanese, or Korean, a value that reads well can still be flagged, and AI suggestions may fall outside the ideal length.

## How to resolve

Each opportunity describes the problem and the recommended change, and shows the current value of the page title or meta description.

* **Page title and meta description:** update them where your site sets them, for example in the page properties in AEM Sites or in the page metadata in Edge Delivery Services. These tags are in the page's head, so **Highlight on page** isn't available for them.
* **H1 heading:** use **Highlight on page** to find the heading in your content. In Edge Delivery Services, the AEM Sites Page Editor, and Adobe Managed Services (AMS), Preflight scrolls to the heading and outlines it; the Page Editor and AMS require **Edit mode**. In the Universal Editor, Preflight selects the heading or the nearest editable block that contains it. A heading in navigation or a footer is brought into view but can't be selected. For more information, see [Highlight on page](../../audit-results.md#highlight-on-page).

To learn how to review and resolve opportunities, see [Audit results in Preflight](../../audit-results.md).
