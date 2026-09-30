# Experience League Markdown — Full Syntax Reference

Condensed from https://experienceleague.adobe.com/en/docs/authoring-guide/using/markdown/markdown-syntax (last confirmed against the "Last update: June 17, 2026" page). Re-fetch the live page if something here seems out of date.

## Frontmatter and title

```markdown
---
title: Title for search optimization
description: This is the article description used for search optimization.
---
# Article title
```

The line immediately after the closing `---` (and one blank line) must be the `# Title` — and it should match `title:` in frontmatter.

## Basic text formatting

- Bold: `**bold**`
- Italic: `*italic*`
- Bold+italic: `***both***`
- Escape a formatting char: `\*not italic\*`
- Paragraphs need no special syntax — just a blank line between them.

## Headings

```markdown
# This is level 1 (article title)
## This is level 2 (mini-TOC entry)
### This is level 3
```

- `#` (H1) = article title, must match frontmatter `title`.
- `##` (H2) = appears in the mini-TOC by default (`mini-toc-levels: 3` in frontmatter to show more levels).
- Never skip a level (`##` → `####` is invalid).
- Blank line required before **and** after every heading.
- Max heading length: 69 characters (EN), 120 (localized).
- Heading ID / anchor: `## Creating processing rules {#processing-rules}` — lowercase, hyphenated. Required if the heading text starts with a numeral (e.g. year). Without an explicit ID, the default anchor is the auto-slugified heading text.

## Notes / admonitions

Standard types: `NOTE`, `TIP`, `IMPORTANT`, `WARNING`. Newer EXL-only types: `ADMIN`, `AVAILABILITY`, `PREREQUISITES`, `INFO`, `ERROR`, `SUCCESS`.

```markdown
>[!NOTE]
>
>This is a standard NOTE block.
>
>It can include multiple paragraphs.
```

Every line of the block starts with `>`. Include a bare `>` line right after the type marker.

## Tabs

```markdown
>[!BEGINTABS]

>[!TAB iOS]

Content for the iOS tab.

>[!TAB Android]

Content for the Android tab.

>[!ENDTABS]
```

- Cannot nest tab sets within tab sets, or tab sets within lists.
- Tab titles are rendered verbatim — no markdown formatting inside `>[!TAB ...]`.
- Multiple tab sets are fine on one page.

## Video

```markdown
>[!VIDEO](https://video.tv.adobe.com/v/27069/?learn=on&enablevpops)
```

- Video must already be hosted on `video.tv.adobe.com` (Adobe TV/MPC) — raw video file links or `<video>` tags are not supported.
- Recommended query params: `?learn=on&enablevpops` (the canonical form used by every embed in this repo). Add `&autoplay=true` to autoplay.
- Transcripts: add `{transcript=true}` to the shortcode, or set `auto-video-transcripts: true` in `TOC.md`/`metadata.md` for the whole guide/repo.

## Badges

Inline badge (renders where placed):
```markdown
[!BADGE Beta]{type=Informative url="https://www.example.com" tooltip="Go to example.com"}
```

Metadata badge (renders above the H1) — in frontmatter:
```yaml
badgePremium: label="Premium" type="Positive" url="https://www.premium-product.com" tooltip="Download Premium"
```

- `type` (case-insensitive): `Informative` (default/blue), `Positive` (green), `Negative` (red), `Neutral` (dark gray), `Caution` (yellow).
- Only the label is required; `type`/`url`/`tooltip` optional.
- Max **two** metadata badges per article (configurable, but ask before relying on an exception).
- Metadata badge values must be quoted. Inline badge `url`/`tooltip` must be quoted.
- Badge URLs used from `TOC.md` must be root-relative (`/help/guide/article.md`), not relative — TOC entries apply across folders.
- `before-title="false"` moves a metadata badge below the H1.
- Add `newtab=true` to open the badge URL in a new tab.

## Images

```markdown
![alt text](assets/logo.png "Hover text"){width="300" align="center"}
```

- `align`: `center` or `right` only — no `left`, no `valign`.
- `width`: pixels (`"300"`) or percentage of view area (`"50%"`).
- `zoomable="yes"` makes the image click-to-enlarge (don't combine with an image that's also a link — the link wins).
- Root-relative path for shared images: `/help/assets/imagename.png`.
- Limits: 100 MB hard cap (GitHub), 5 MB before you should start caring, 20 MB triggers a validation error. Max 100 images per article (EDS rendering limit).

## Links and cross-references

- External: `[Adobe](https://www.adobe.com)`
- Bare URL as a link: `<https://www.adobe.com>` — an unwrapped bare URL does **not** auto-link.
- Relative cross-reference: `[Overview](collaborative-doc-instructions/overview.md)` — resolve from the *source* file's location; supports `./`, `../`, `../../`.
- Root-relative cross-reference: `[Overview](/help/using/docile-rules/introduction.md)` — works from any file in the repo regardless of source location.
- Deep link to a heading: target needs `{#heading-id}`; link with `[Text](file.md#heading-id)` (or just `#heading-id` for same-page).
- Open in new tab: `[See What's new](whats-new.md){target="_blank"}`.

## Lists

```markdown
1. This is step 1.
1. This is the next step.
   1. Sub-step (indent 3 spaces for numbered lists)
   1. Sub-step
```

```markdown
* First item.
* Second item.
```

- Numbered lists: always write `1.` (or always `1)`) — GitHub renders the real sequence. Pick one style (`.` vs `)`) and stay consistent within the article.
- Bullet lists: pick one of `*`, `-`, `+` and stay consistent — mixing them in the same article is a validation error. Convention in most repos: `*`.
- Blank line required before and after any list.
- Content between list items (images, tables, notes) must be indented to the text start (3 spaces for numbered lists, 2 for bullet lists) or it breaks the list. Over-indenting (6 spaces) turns it into a code block instead.

## Code blocks

Inline: `` `code` `` — or wrap in triple backticks inline if you need a literal backtick inside.

Fenced:
````markdown
```javascript
var x = 1;
```
````

- Always specify a language for syntax highlighting + the Copy button.
- Blank line required above and below the fenced block.
- Line numbers: `` ```html {line-numbers="true"} ``
- Start numbering elsewhere: `` ```html {line-numbers="true" start-line="7"} ``
- Highlight lines: `` ```html {line-numbers="true" start-line="7" highlight="11-13, 16"} ``
- Code block content is never localized (except `!UICONTROL`/`!DNL` tags, which get stripped at publish time).
- No markdown/HTML formatting (like `<i>`) works inside code blocks — use angle brackets or plain text for placeholders.

## Tables

- Standard GFM pipe tables work for simple cases.
- HTML tables are allowed for special cases (e.g., a table with no header row) — prefer markdown otherwise.
- Limited HTML is allowed inside markdown table cells: `<p>`, `<br>`, `<ul>`, `<ol>`.
- Tables can be set to auto or fixed rendering — see the "Tables" article linked from the syntax guide if you need that level of control.

## Collapsible sections

```markdown
+++See details

This is text inside a collapsible section.

* Bullet one
* Bullet two

+++
```

- Don't nest collapsible sections — they won't render correctly (and won't fail validation, so the bug ships silently).
- Blank lines around inner lists/code blocks inside the section are required, same as anywhere else.

## Text highlighting

```markdown
This sentence is normal. <span class="preview">This text is highlighted.</span>
```

Use `<span class="preview">` for inline/paragraph highlighting, `<div class="preview">` for multiple paragraphs/components.

## Snippets and includes

- Shared H2 anchors from a repo's `help/snippets.md`: reference with `{{anchor-id}}`.
- Shared include files from `help/_includes/*.md`: reference with `{{$include /help/_includes/filename.md}}`.

## Comments

```markdown
<!-- standard comment code -->
```

- Never use `<!--> bad comment syntax <-->` (missing dashes) — it renders visibly instead of hiding the text.
- Comments are invisible in the rendered docs but **visible to anyone viewing the raw .md on GitHub** — no secrets or confidential info.
- Avoid comments inside bullet lists (can break list rendering). In `TOC.md`, only comment out lines at the end of the file, never in the middle of the list.

## Blank-line workaround

Extra blank lines in the source are collapsed by the renderer. To force visible vertical space, put `<br>&nbsp;` on its own line where you want the gap.

## Escaping characters

- Backslash-escapable characters: `` # { } [ ] * + - . ! ``  — e.g. `\# not a heading`.
- For angle brackets (`<placeholder>`), backslash doesn't work — use an inline code block (`` `<placeholder>` ``) or HTML entities (`&lt;placeholder&gt;`).
- HTML entities inside code blocks are **not** converted back to the character — `&gt;` stays literal text there.
- Metadata (YAML frontmatter) has its own escaping rules — if a value starts with a special character like `:` or `[`, quote the whole value: `title: "Processing rules: A new beginning"`.

## Restricted HTML allowlist

Only these HTML tags are permitted anywhere in markdown; anything else is a validation error:

```
table  tbody  td  tfoot  thead  th  tr  col  colgroup
p  ul  ol  li  br
b  i  strong  u  s  em  sub  sup  span
caption  a  img  div
pre  code  codeblock
```

Prefer markdown syntax over HTML wherever markdown can do the job — HTML is really only for edge cases like a header-less table.

## Explicitly unsupported (don't use even if a local preview renders them)

- Horizontal rules (`***`, `<hr>`)
- Emoji shortcodes (`:bowtie:`)
- Task lists (`- [x] done`)
- Blockquote *components* beyond the note/tab/video shortcodes (plain `>` blockquotes render as a quote, not a styled component)
- Markdown definition-list syntax (use manual bold + dash formatting instead: `**Frog** - An amphibious green creature.`)
- `valign` on images

## File-size / count limits worth knowing

| Thing | Limit |
|---|---|
| Image/download file size | Validation warning at 5 MB, error at 20 MB, hard GitHub cap 100 MB |
| Images per article | 100 (EDS rendering limit) |
| Metadata badges per article | 2 (default) |
