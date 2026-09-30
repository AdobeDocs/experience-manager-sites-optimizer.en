---
name: experience-league-video-upload
description: Use when a user wants to submit/upload a video to Experience League (video.tv.adobe.com / KT video submission) for embedding via >[!VIDEO] in this repo's markdown — covers filling the submission form with browser automation, this repo's defaults, and what must never be automated.
---

# Experience League Video Upload

## Overview

Experience League videos aren't hosted in this repo — a local `.mp4` gets uploaded through a separate submission form, which returns a `video.tv.adobe.com` URL you then embed with `>[!VIDEO](...)` (see [[experience-league-markdown]]). This skill fills that form via browser automation, up to (not including) attaching the file and submitting.

Form: https://81368-exlmpcvideoupload.adobeio-static.net/#/

## Video file recommendation

Before the user records or selects a clip, recommend a **16:9 aspect ratio** at a **maximum resolution of 1920 x 1080 pixels** — this is the form's own stated requirement, not just a style preference. Mention it proactively (e.g. when a user says they're about to capture a screen recording for this), not only if asked.

## Hard rule: never attach the file or submit

Submitting creates a real KT Jira ticket and uploads to the production video platform — an outward-facing, hard-to-reverse action. **Always** stop once every other field is filled and hand back to the user for the video file and the final submit click, even if they don't repeat the instruction next time. This is the default for this skill, not something that needs re-confirming per request — only skip this stop if the user explicitly says to submit for them in that same request.

## Prerequisites

Needs the `chrome-devtools` MCP server, which is **not** committed to this repo (a browser-automation MCP shouldn't be forced on every contributor). If it's not loaded:

1. Create `.mcp.json` at the repo root:
   ```json
   {
     "mcpServers": {
       "chrome-devtools": {
         "command": "npx",
         "args": ["-y", "chrome-devtools-mcp@latest", "--accept-insecure-certs", "--no-usage-statistics"]
       }
     }
   }
   ```
2. Add `.mcp.json` to `.gitignore` (personal tooling, not shared).
3. In `.claude/settings.local.json`, add `"enableAllProjectMcpServers": true` and `"enabledMcpjsonServers": ["chrome-devtools"]`.
4. Tell the user to restart Claude Code (or run `/mcp`) — MCP servers only load at startup, this can't be done mid-session.

## This repo's defaults

Unless the user says otherwise, use:

| Field | Default | Why |
|---|---|---|
| Cloud | `Experience Cloud` | — |
| Product | `AEM` | User-specified default for this repo (the form also lists `AEM as a Cloud Service` — don't substitute it unless asked) |
| Sub-product | `AEM Sites` | Closest match; the form has no "Sites Optimizer" entry |
| Roles | `User` | Preflight/Sites Optimizer content is aimed at authors/marketers, not admins/devs, unless the video is clearly for a technical audience |
| Skill levels | `Beginner` | Unless the workflow shown has real prerequisites |
| Video voice(s) gender | `No voices` | Only for silent screen recordings — ask if the clip has narration |
| Video type | Ask, or infer from content | Live options are `Event` / `Feature` / `Technical` / `Value` — a UI walkthrough is usually `Feature` |
| Email | whatever is pre-filled | The form auto-fills the logged-in user's Adobe email; don't overwrite it |

## Steps

1. `mcp__chrome-devtools__new_page` to the form URL.
2. `mcp__chrome-devtools__take_snapshot` and wait (`mcp__chrome-devtools__wait_for` on `"Title"`) until form data finishes loading — it starts on a "Loading form data..." spinner.
3. Fill **Title** and **Description** — Description is a contenteditable rich-text box, not a plain `<textarea>`. `fill`/`fill_form` on it silently no-ops (the value doesn't take and the "required" error stays). Instead: `click` it to focus, then `mcp__chrome-devtools__type_text` with the text.
4. The dropdowns (**Video type**, **Video voice(s) gender**, **Cloud**, **Product**, **Sub-product**, **Event name**) are custom listbox buttons, not native `<select>`. For each: `click` the button to open it, read the real options from the snapshot (they're API-loaded — don't assume the defaults table's exact option spelling is still current), then `click` the matching `option`.
5. **Product** and **Sub-product** are disabled until their parent field is set (Product needs Cloud; Sub-product needs Product) — fill them in that order.
6. **Roles** and **Skill levels** are checkbox groups — `fill_form` with `"value": "true"` on the checkbox `uid`s works fine here (unlike the description field).
7. Stop. Take a screenshot, summarize what was set and why (especially any default that was substituted, like Product/Sub-product), and tell the user to attach the video and submit themselves.
8. After the user says they've submitted, ask them for the resulting Adobe MPC video URL (shown on the form after upload, e.g. `https://video.tv.adobe.com/v/3496629?learn=on`). Use it to fill in the `>[!VIDEO](...)` shortcode wherever this video was meant to go — don't fabricate or guess the URL/ID yourself.

## Validating a returned video URL

Whenever a user hands you a video URL to embed (step 8 above, or any other time):

- **Reject anything not on `video.tv.adobe.com`.** Videos must be hosted there per [[experience-league-markdown]] — a link to YouTube, a file host, or any other domain is not a valid `>[!VIDEO]` target. Tell the user it needs to go through this repo's upload flow first; don't embed it.
- **If it's a valid `video.tv.adobe.com` URL missing `&enablevpops`, add it** before embedding (matches the convention already used by every other `>[!VIDEO]` in this repo — see `help/home.md`, `help/documentation/trial.md`, etc.). Append `&enablevpops` if there's already a `?`, otherwise `?enablevpops`.

## Common mistakes

- Trying `fill`/`fill_form` on the Description field and moving on when the error banner still shows "A description is required." — check the error list after every step, not just at the end.
- Guessing dropdown option text from memory instead of opening the dropdown — the actual values (e.g. `No voices` for voice gender, `Feature`/`Technical`/`Value` for video type, the AEM/AEM-as-a-Cloud-Service split under Product) aren't guessable and change independently of this doc.
- Clicking **Upload video** / attaching a file "to save the user a step." Don't — see Hard rule above.
