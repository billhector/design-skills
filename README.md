# Design Skills for Claude Code

Two Claude Code skills that turn any website or existing project into a documented design system — with Tailwind v4 theme generation and WCAG accessibility checks.

## Skills

### design-extractor

Give it a URL, get back a complete design system. Scrapes the site with Firecrawl, analyzes the HTML for design tokens, and generates:

- **DESIGN.md** — colors, typography, components, spacing, elevation, layout, responsive behavior
- **tailwind-theme.css** — Tailwind v4 `@theme` block with semantic tokens, fluid spacing, and `color-mix()` variants
- **accessibility-report.md** — WCAG AA/AAA contrast checks for every surface/text pair, colorblindness simulation, suggested fixes

### design-auditor

Point it at an existing project. Reads your CSS, Tailwind config, WordPress theme.json, or HTML templates and generates the same three files — plus handles migration:

- **Tailwind v4 already?** Validates and normalizes your existing theme
- **Tailwind v3?** Converts your config to v4 `@theme` format
- **No Tailwind?** Generates a fresh theme from your extracted values
- **WordPress theme.json?** Maps palette, fonts, and spacing to Tailwind tokens

## Usage

These are Claude Code skills — you invoke them with natural language in a Claude Code session:

```
"Extract the design from stripe.com"
"Grab the design from linear.app"
"Audit my design"
"Audit this project's design system"
"Migrate to Tailwind"
```

Both skills ask you to name the design before saving. Extracted designs are saved to a reusable library at `~/.claude/designs/`. You can apply a saved design to any project later:

```
"Use the stripe design"
```

This copies the DESIGN.md, tailwind-theme.css, and accessibility-report.md into your current project's `.claude/design/` directory, where other skills (like `design-system-standards` or `frontend-design`) can pick them up automatically.

## What Makes This Different

Most existing tools handle one piece — scraping, or token extraction, or Tailwind config, or accessibility. These skills combine the full pipeline in a single pass:

| Step | What happens |
|------|-------------|
| Scrape or scan | Firecrawl for URLs, local file reading for projects |
| Extract tokens | Colors, typography, spacing, radius, shadows, layout, breakpoints |
| Generate theme | Tailwind v4 `@theme` with semantic tokens and fluid spacing |
| Check accessibility | WCAG contrast ratios + colorblindness simulation |
| Save to library | Reusable across projects via `~/.claude/designs/` |

No other Claude Code skill does all five.

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

1. A Firecrawl account at [firecrawl.dev](https://firecrawl.dev) — **the free tier includes 500 credits**, which is plenty to get started (each extraction uses 1 credit). Paid plans are available if you need more.
2. The Firecrawl CLI installed and authenticated:

```bash
npx -y firecrawl-cli@latest init --all --browser
```

The **design-auditor does not require Firecrawl** — it reads local project files only, no account or network access needed.

## Install

Copy the skill folders into your Claude Code skills directory:

```bash
git clone https://github.com/billhector/design-skills.git
cp -r design-skills/skills/design-extractor ~/.claude/skills/
cp -r design-skills/skills/design-auditor ~/.claude/skills/
```

That's it. The skills will be available in your next Claude Code session.

## Output

Both skills produce three files:

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

- Semantic color tokens (`--color-primary`, `--color-secondary`, `--color-accent`, etc.)
- `color-mix()` light/dark variants for primary, secondary, and accent
- Fluid spacing using `clamp()` (xxs through xxl)
- Border radius scale
- Font family with fallback stack
- Commented `@font-face` template (fonts need to be self-hosted separately)

### accessibility-report.md

- Contrast ratio table for every surface/text pair
- WCAG AA and AAA pass/fail for both normal and large text
- Suggested fixes for each failing pair (specific hex values to meet the threshold)
- Colorblindness simulation — flags pairs that become indistinguishable under protanopia, deuteranopia, or tritanopia
- Summary with pass rates and critical failure count

## File Locations

| Context | Location |
|---------|----------|
| Design library | `~/.claude/designs/<name>/` |
| Library index | `~/.claude/designs/_index.md` |
| Per-project | `.claude/design/` in your project root |

The library is created automatically on first use. The per-project directory is created when you run the auditor or say "use the \<name\> design."

## License

MIT
