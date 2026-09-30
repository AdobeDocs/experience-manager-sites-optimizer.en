#!/bin/sh
# Reminds the agent to validate Experience League markdown after editing a docs .md file.
# Fires on PostToolUse for Write|Edit. Only nudges for markdown files under help/.
if command -v jq >/dev/null 2>&1; then
  f=$(jq -r '.tool_input.file_path // ""')
else
  f=$(grep -o '"file_path":"[^"]*"' | head -1 | sed 's/"file_path":"//;s/"//')
fi
# Normalize Windows backslash separators so the glob match below works
# regardless of whether the path arrives as help/foo.md or help\foo.md.
f=$(printf '%s' "$f" | tr '\\' '/')
case "$f" in
  *help/*.md)
    echo '{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":"You just edited an Experience League docs .md file under help/. Before marking this task complete, use the experience-league-markdown skill to verify the change follows the required syntax: frontmatter + H1, note/tab/video shortcodes, badges, images (align/width), links/cross-references, lists, code blocks, and the restricted HTML tag allowlist (no raw <video>, <hr>, task lists, or emoji)."}}'
    ;;
esac
