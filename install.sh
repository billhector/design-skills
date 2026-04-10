#!/bin/bash

# Install design-extractor and design-auditor skills for Claude Code

SKILLS_DIR="$HOME/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Copy skills
mkdir -p "$SKILLS_DIR/design-extractor" "$SKILLS_DIR/design-auditor"
cp "$SCRIPT_DIR/skills/design-extractor/SKILL.md" "$SKILLS_DIR/design-extractor/SKILL.md"
cp "$SCRIPT_DIR/skills/design-auditor/SKILL.md" "$SKILLS_DIR/design-auditor/SKILL.md"

echo "Installed design-extractor and design-auditor to $SKILLS_DIR"
echo ""
echo "Optional: create the design library directory:"
echo "  mkdir -p ~/.claude/designs"
echo ""
echo "Add the following to your ~/.claude/CLAUDE.md (in your CSS/Frontend or Skills section):"
echo ""
echo "  - Design library at ~/.claude/designs/ — use design-extractor to grab designs from URLs, design-auditor to audit existing projects"
echo "  - Per-project design files go in .claude/design/ (DESIGN.md, tailwind-theme.css, accessibility-report.md, preview.png)"
echo "  - If .claude/design/DESIGN.md exists in a project, read it first and use those tokens"
echo "  - Design skill workflow: extract/audit → validate with design-system-standards → check with tailwind-patterns → build with frontend-design"
echo ""
echo "Done. Start a new Claude Code session to use the skills."
