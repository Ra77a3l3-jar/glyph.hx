# glyph.hx

A Nerd Font icon and color library for [Helix](https://github.com/helix-editor/helix/) plugins.

glyph.hx doesn't do anything on its own — it's a shared lookup table other plugins `require` so they can show colored file-type, folder, and git-status icons without each one maintaining its own copy.

---

## Requirements

- Helix with Steel scripting enabled (the Steel modules are bundled with Helix itself)
- A [Nerd Font](https://www.nerdfonts.com/) installed and active in your terminal

---

## Installation

**1. Install the plugin-enabled fork of Helix** by following the instructions [here](https://github.com/mattwparas/helix/blob/steel-event-system/STEEL.md).

**2. Install glyph.hx via forge:**

```sh
forge pkg install --git https://github.com/Ra77a3l3-jar/glyph.hx.git
```

Plugins that depend on glyph.hx pull it in automatically via `forge`:

```scheme
;; cog.scm
(define dependencies
  '((#:name glyph #:git-url "https://github.com/Ra77a3l3-jar/glyph.hx.git")))
```

---

## Usage

This plugin is intended to be used by other plugins from [Steel](https://github.com/mattwparas/steel), not invoked directly:

```scheme
(require "glyph/glyph.scm")

(glyph-icon "main.rs")       ; Rust's Nerd Font icon
(glyph-color "main.rs")      ; -> "#dea584"

(glyph-dir-icon "src")       ; the icon mini.icons uses for a src/ directory
(glyph-dir-color "src")      ; -> "#9d7cd8"

(glyph-git-icon 'modified)   ; -> "~"
(glyph-git-color 'modified)  ; -> "#cbcb41"

;; turns any of the hex colors above into a real Style, ready for
;; frame-set-string! or add-inlay-hint
(glyph-style (glyph-color "main.rs"))
```

### API

| Function | Takes | Returns |
|---|---|---|
| `glyph-icon` | a file name | its Nerd Font icon, or a generic file icon if unknown |
| `glyph-color` | a file name | its hex color, or a neutral gray if unknown |
| `glyph-dir-icon` | a directory name | its Nerd Font icon, or a generic folder icon if unknown |
| `glyph-dir-color` | a directory name | its hex color, or a neutral azure if unknown |
| `glyph-git-icon` | a git status symbol | its icon (see table below) |
| `glyph-git-color` | a git status symbol | its hex color |
| `glyph-style` | a hex color, `#:base` (optional) | a `Style` with that color as foreground, built on top of `#:base` (defaults to the current theme's `ui.text`) |

File and directory lookups match first by exact name (`Makefile`, `.git`, `README`, ...), then by extension, falling back to a generic icon if nothing matches.

---

## Credits

Icons are sourced from [mini.icons](https://github.com/echasnovski/mini.nvim).
