---
name: experience-league-markdown
description: Use when writing or editing Markdown files in an Adobe Experience League / Adobe-Enterprise-Docs repo (help/**/*.md) — governs frontmatter, headings, notes (NOTE/TIP/IMPORTANT/WARNING/etc.), tabs (BEGINTABS/TAB/ENDTABS), video embeds, badges, images, links/cross-references, tables, lists, code blocks, and the restricted HTML tag allowlist that Experience League's validation pipeline enforces.
---

# Experience League Markdown

## Overview

Experience League docs use GitHub-flavored Markdown plus a set of custom extensions (blockquote-based shortcodes, badges, tabs, video embeds). The authoring pipeline **validates** these files — using unsupported syntax (raw `<video>` tags, `<hr>`, task lists, mixed bullet characters, skipped heading levels, oversized images) causes a build/validation error, not just a style nit.

Source of truth: https://experienceleague.adobe.com/en/docs/authoring-guide/using/markdown/markdown-syntax (fetch this page if the local reference.md seems stale — "Last update" date is at the top).

Full syntax reference with every shortcode and rule: [reference.md](reference.md). Read it before writing anything non-trivial (tabs, video, badges, tables with HTML).

## Quick Reference

| Element | Syntax | Notes |
|---|---|---|
| Frontmatter | `---\ntitle: ...\ndescription: ...\n---` | Blank line, then `# Title` must come next |
| Heading levels | `#`, `##`, `###` | `#` = title (matches frontmatter `title`), `##` = mini-TOC entries. Never skip a level. Blank line before/after. Max 69 chars (EN) |
| Heading ID | `## Heading text {#custom-id}` | Required if heading starts with/contains a numeral, e.g. `## 2026 release notes {#2026-release-notes}` |
| Note/Tip/etc. | `>[!NOTE]` then `>` then `>Text` (each on its own line) | Types: NOTE, TIP, IMPORTANT, WARNING, CAUTION, ADMIN, AVAILABILITY, PREREQUISITES, INFO, ERROR, SUCCESS |
| Tabs | `>[!BEGINTABS]` / `>[!TAB Title]` / `>[!ENDTABS]` | Can't nest tab sets; can't nest inside lists |
| Video | `>[!VIDEO](https://video.tv.adobe.com/v/ID/?learn=on&enablevpops)` | Must be hosted on video.tv.adobe.com — no raw `<video>`/file links |
| Image | `![alt text](assets/img.png "hover text"){width="300" align="center"}` | `align` is `center` or `right` only (no `left`, no `valign`) |
| Link (relative) | `[Text](../folder/file.md)` | Account for source file's location |
| Link (root) | `[Text](/help/guide/file.md)` | Works from anywhere in the repo; required for TOC.md badge URLs |
| Deep link | `[Text](file.md#heading-id)` | Target heading needs an explicit `{#heading-id}` |
| External link (bare URL) | `<https://example.com>` | Bare URLs are NOT auto-linked — wrap in `< >` or use `[text](url)` |
| Bullet list | `* item` (pick one of `*`/`-`/`+`, stay consistent) | Blank line before/after list; mixing markers = validation error |
| Numbered list | `1. item` (repeat `1.` every line) | GitHub renders the real numbers |
| Code (inline) | `` `code` `` | For file names, commands, values, unvalidated sample URLs |
| Code (fenced) | ` ```language ` ... ` ``` ` | Always specify a language; blank line before/after; `{line-numbers="true" start-line="n" highlight="n-m"}` optional |
| Badge (inline) | `[!BADGE Beta]{type=Informative url="..." tooltip="..."}` | `type`: Informative/Positive/Negative/Neutral/Caution |
| Collapsible | `+++Summary` ... `+++` | No nested collapsibles; blank lines around inner lists/code |
| Blank line hack | `<br>&nbsp;` on its own line | Plain extra blank lines are collapsed/ignored by the renderer |
| Comment | `<!-- text -->` | Never `<!--> text <-->` — visible to anyone viewing the raw file on GitHub, so no secrets |

## Common Mistakes

- **Raw `<video>`, `<iframe>`, or other non-allowlisted HTML** → validation error. The HTML allowlist is: `table tbody td tfoot thead th tr col colgroup p ul ol li br b caption i strong u s span sub sup a img div em pre code codeblock`. Anything else (including `<video>`/`<source>`) is rejected — use the `>[!VIDEO]` shortcode instead, which requires the video to already be hosted on video.tv.adobe.com.
- **`<hr>` / `***` horizontal rules, emoji shortcodes (`:bowtie:`), task lists (`- [x]`)** — none are supported; don't use them even if a local preview renders them.
- **Mixing bullet characters** (`*` and `-` in the same list) — validation error. Pick one per article.
- **Skipping heading levels** (`##` straight to `####`) — not allowed.
- **A numeral-leading heading without an explicit ID** (e.g. `## 2026 release notes`) — must add `{#some-id}` or the auto-slug can collide/break.
- **Bare URLs in prose** (`Visit https://example.com for more`) — won't render as a link. Wrap in `< >` or use `[text](url)`.
- **Extra blank lines for visual spacing** — collapsed by the renderer. Use `<br>&nbsp;` instead of a bare `<br>` or repeated newlines.
- **Images over ~5 MB** — validation warning at 5 MB, error at 20 MB. More than 100 images in one article breaks rendering (EDS limit).
- **More than two badges in frontmatter metadata** — not allowed by default.
- **Escaping issues**: backslash-escape only works for `` # { } [ ] * + - . ! ``. For `<` `>` in things like `<filename>` placeholders, use an inline code block or HTML entities (`&lt;filename&gt;`), not a backslash.

## Before Committing Markdown Changes

1. Frontmatter present, `# Title` immediately follows (after the blank line).
2. Every heading has a blank line before and after; no skipped levels.
3. Any video is `>[!VIDEO](https://video.tv.adobe.com/...)`, not a raw `<video>` tag.
4. Any custom shortcode (`>[!NOTE]`, `>[!BEGINTABS]`, `>[!BADGE ...]`) matches the exact syntax in [reference.md](reference.md) — including the blank `>` line inside multi-line blocks.
5. Lists use one consistent bullet/number style, with blank lines around the whole list.
6. Links: relative links resolve from the *source* file's folder; cross-repo or TOC/badge links use root-relative (`/help/...`) form.
7. No HTML tag outside the allowlist in the Common Mistakes section above.
