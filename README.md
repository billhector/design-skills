# Design Skills for Claude Code

Two Claude Code skills that extract, document, and audit visual design systems — with Tailwind v4 theme generation and WCAG accessibility checks built in.

## Skills

### design-extractor

Extract a design system from any website URL. Point it at a site, get back three files:

- **DESIGN.md** — full design system spec (colors, typography, components, spacing, elevation, layout, responsive behavior)
- **tailwind-theme.css** — Tailwind v4 `@theme` block with semantic tokens, fluid spacing, and `color-mix()` variants
- **accessibility-report.md** — WCAG contrast ratios for every surface/text pair, colorblindness simulation flags, suggested fixes

**Usage:** "Extract the design from stripe.com"

### design-auditor

Audit an existing project's CSS, Tailwind config, WordPress theme.json, or HTML templates. Produces the same three output files, plus handles Tailwind migration:

- **Tailwind v4 already?** Validates and normalizes your existing theme
- **Tailwind v3?** Converts your config to v4 `@theme` format
- **No Tailwind?** Generates a fresh theme from your extracted values
- **WordPress theme.json?** Maps palette, fonts, and spacing to Tailwind tokens

**Usage:** "Audit my design" or "Migrate to Tailwind"

## What Makes This Different

Most tools handle one piece. These skills combine the full pipeline in a single pass:

1. **Scrape or scan** — Firecrawl for URLs, local file reading for projects
2. **Extract tokens** — colors (primary, secondary, accent, neutral, status, surface, border), typography, spacing, radius, shadows, layout, breakpoints
3. **Generate Tailwind v4 theme** — semantic tokens, fluid `clamp()` spacing, `color-mix()` light/dark variants
4. **Accessibility audit** — WCAG AA/AAA contrast checks + protanopia/deuteranopia/tritanopia colorblindness simulation
5. **Library management** — save to `~/.claude/designs/` for reuse across projects

## Requirements

| Requirement | design-extractor | design-auditor |
|-------------|:---:|:---:|
| [Claude Code](https://claude.ai/code) | Required | Required |
| [Node.js](https://nodejs.org/) (v18+) | Required | - |
| [Firecrawl CLI](https://firecrawl.dev) + account | Required | - |

### Claude Code

Both skills are [Claude Code skills](https://docs.anthropic.com/en/docs/claude-code/skills) — they run inside Claude Code sessions, not standalone. You need Claude Code installed and working.

### Firecrawl CLI (design-extractor only)

The extractor uses Firecrawl to scrape websites. You need:

1. A Firecrawl account at [firecrawl.dev](https://firecrawl.dev) (free tier includes 500 credits)
2. The Firecrawl CLI installed and authenticated:

```bash
npx -y firecrawl-cli@latest init --all --browser
```

The design-auditor reads local project files only — no Firecrawl or network access needed.

## Install

Copy the skill folders into your Claude Code skills directory:

```bash
# Clone the repo
git clone https://github.com/billhector/design-skills.git

# Copy skills to your Claude Code skills directory
cp -r design-skills/skills/design-extractor ~/.claude/skills/
cp -r design-skills/skills/design-auditor ~/.claude/skills/
```

Or manually copy the `SKILL.md` files:

```
~/.claude/skills/design-extractor/SKILL.md
~/.claude/skills/design-auditor/SKILL.md
```

### Optional: Design Library

Create a library directory to save and reuse designs across projects:

```bash
mkdir -p ~/.claude/designs
```

The skills will create this automatically on first use.

## Output Format

Both skills produce three files with identical structure:

### DESIGN.md

Nine sections covering the complete design system:

1. Visual Theme & Atmosphere
2. Color Palette (primary, secondary, accent, neutral, status, surface, border)
3. Typography (font families, full scale table)
4. Components (buttons, cards, forms, badges)
5. Layout (grids, max-widths, containers)
6. Spacing (mapped to semantic scale: xxs through xxl)
7. Border Radius (micro, button, card, featured)
8. Elevation (shadow levels 0-4 + focus)
9. Responsive Behavior (breakpoints and changes)

### tailwind-theme.css

A ready-to-import Tailwind v4 `@theme` block:

- Semantic color tokens with `color-mix()` light/dark variants
- Fluid spacing using `clamp()`
- Border radius scale
- Font family with fallback stack
- Commented `@font-face` template

### accessibility-report.md

- Contrast ratio table for every surface/text pair
- WCAG AA and AAA pass/fail for normal and large text
- Suggested fixes for failing pairs
- Colorblindness simulation (protanopia, deuteranopia, tritanopia)
- Summary with pass rates

## File Locations

| Context | Location |
|---------|----------|
| Design library | `~/.claude/designs/<name>/` |
| Library index | `~/.claude/designs/_index.md` |
| Per-project | `.claude/design/` in your project root |

## License

MIT
