---
title: Preflight Lorem Ipsum Audit
description: Learn about the Lorem ipsum audit in Preflight for AEM Sites Optimizer.
product_v2:
  - id: fd1f54a9-f50c-467d-8956-cebbaf4f3eb8
    internal-label: Experience Manager
---
# Lorem ipsum audit

The **Lorem ipsum** audit detects placeholder text that has been left in your page content.

## Why it matters

Publishing a page with placeholder text makes it look unfinished to readers. Search engines can index the placeholder text and show it in search results, and social platforms can show it in link previews. Placeholder text is often hidden from view, for example in image alt text or accessibility labels. When it is, people who use screen readers or other assistive technologies may still hear it, even though it doesn't appear on the page.

## What the audit checks

The audit reports each place on the page where placeholder text appears. It checks visible page text, plus several places where it may not be visible immediately or at all:

* image alt text
* accessibility labels and descriptions
* form field placeholders
* tooltips
* the page title
* metadata, such as the meta description and social sharing tags

Code that isn't presented to users, such as scripts and styles, isn't checked.

## How the text is matched

The audit looks for the phrase "lorem ipsum" in any combination of uppercase and lowercase letters. It also finds the phrase when the words are split across lines or elements, or have no space between them. If the phrase appears more than once in the same element or attribute, that place is reported once.

## Known limitations

* **Only "lorem ipsum":** other placeholder text, such as "TBD" or other Latin filler words without "lorem ipsum", isn't detected.
* **Highlight on page:** isn't available for the page title or metadata, because they don't appear on the page. Use the text shown in the opportunity to find them.

## How to resolve

When the audit finds opportunities, each one identifies where the placeholder text appears. Where it's available, use **Highlight on page** to jump to the text in your content. Replace the placeholder with real content, or remove it. For alt text and accessibility labels, write a description of the image or control. To learn how to review and resolve opportunities, see [Audit results in Preflight](../../audit-results.md).
