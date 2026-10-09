---
title: Preflight Headings Audit
description: Learn about the Headings audit in Preflight for AEM Sites Optimizer.
---
# Headings audit

The **Headings** audit reviews the subheadings on your page (H2 to H6). It flags headings that have no text and headings that skip a level, such as an H2 followed directly by an H4.

## Why it matters

Headings give a page its outline. Readers scan them to find what they need, screen reader users move through a page by its headings, and search engines use them to understand how the content is organized. An empty heading adds a stop in that outline with nothing in it, and a skipped level makes the structure harder to follow.

## What the audit checks

The audit reports an opportunity for each of the following problems:

* **Empty heading:** an H2, H3, H4, H5, or H6 that has no text. A heading that contains only spaces, or only an image, counts as empty.
* **Skipped heading level:** a heading that is more than one level deeper than the heading just before it, for example an H2 followed by an H4, or an H1 followed by an H3. The opportunity is reported on the deeper heading.

Both are reported at moderate impact.

H1 headings are reviewed by the [Metatags](./metatags.md) audit, which checks for a missing, empty, or overly long H1 and for more than one H1 on a page.

## How headings are read

The audit reads the page you are editing and looks at every heading in the order it appears:

* All headings count, including headings in the page header, navigation, and footer, and headings that are hidden on screen.
* Only the step from one heading to the next is checked. A page whose first heading is an H3 is not flagged for that.
* Headings can go back up any number of levels, for example from an H4 back to an H2.

## Suggestions

Every opportunity includes a recommendation and fixed advice for the change to make. The Headings audit doesn't generate AI suggestions.

## If a flagged heading looks correct to you

If an opportunity doesn't match what you expect, one of the following is usually the reason:

* **The heading is part of your page template.** Headings in the header, navigation, or footer are checked along with your content, so a footer heading that is several levels deeper than the last heading in your content can be flagged as a skipped level. Fixing it in the template resolves it on every page that uses the template.
* **The heading contains only an image or icon.** A heading with no text is reported as empty even when it shows an image. Add text to the heading, or use a non-heading element for the image.

## Known limitations

* **Visibility isn't considered:** headings that are hidden on screen are still checked.
* **Very large pages:** pages with more than 500 headings aren't checked.

## How to resolve

When the audit finds opportunities, each one describes the problem and the recommended change.

* **Empty heading:** add descriptive text to the heading, or remove it if it isn't needed.
* **Skipped heading level:** change the heading to the next level down from the heading before it (for example, an H4 after an H2 becomes an H3), or add the missing level in between.

Use **Highlight on page** to find the heading in your content. How the heading is highlighted depends on where you run Preflight:

* **Edge Delivery Services:** Preflight scrolls to the heading and outlines it.
* **AEM Sites Page Editor and Adobe Managed Services (AMS):** Preflight scrolls to the heading and outlines it. Highlighting requires **Edit mode**.
* **Universal Editor:** Preflight selects the heading itself, or the nearest editable block that contains it. For a heading in content the editor doesn't manage, such as navigation or a footer, Preflight brings it into view but can't select the heading itself.

For more information, see [Highlight on page](../../audit-results.md#highlight-on-page).

To learn how to review and resolve opportunities, see [Audit results in Preflight](../../audit-results.md).
