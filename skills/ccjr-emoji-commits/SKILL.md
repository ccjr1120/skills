---
name: ccjr-emoji-commits
description: Emoji commit convention for AI-assisted commits. Use when committing code — automatically prefix the commit message with the correct emoji based on the conventional commit type.
---

# Emoji Commit Convention

When making a git commit, prefix the message with the matching emoji:

| Type       | Emoji |
|------------|-------|
| `init`     | 🌱    |
| `feat`     | ✨    |
| `wip`      | 💬    |
| `fix`      | 🔨    |
| `docs`     | 📝    |
| `style`    | 🎨    |
| `refactor` | ♻️    |
| `test`     | ✅    |
| `chore`    | 📦️   |
| `release`  | 🚀    |
| (unknown)  | 🏷️   |

**Example:** `feat: add login` → `✨ feat: add login`

Extract the type from `type:` or `type(scope):` at the start of the message. If no type matches, use 🏷️.
