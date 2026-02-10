import { readFileSync, writeFileSync } from "fs";

const EMOJI_MAP = {
  init: "🌱",
  feat: "✨",
  wip: "💬",
  fix: "🔨",
  docs: "📝",
  style: "🎨",
  refactor: "♻️",
  test: "✅",
  chore: "📦️",
  release: "🚀",
};

const msgFile = process.argv[2];
const msg = readFileSync(msgFile, "utf8").trim();

// Extract type from "type:" or "type(scope):"
const typeMatch = msg.match(/^([a-z]+)(?:\([^)]*\))?:/);
const type = typeMatch ? typeMatch[1] : null;
const emoji = type ? EMOJI_MAP[type] : "🏷️";

if (emoji && !msg.startsWith(emoji)) {
  writeFileSync(msgFile, `${emoji} ${msg}\n`, "utf8");
}
