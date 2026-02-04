# Neovim Plugin Cheat Sheet

## Quick Reference

| Action | Keys | Plugin |
|--------|------|--------|
| Go to definition | `gd` | LSP |
| Find references | `gr` | LSP |
| Hover docs | `K` | LSP |
| Rename symbol | `<leader>rn` | LSP |
| Code action | `<leader>ca` | LSP |
| Next diagnostic | `]d` | LSP |
| Comment line | `gcc` | Comment.nvim |
| Comment motion | `gc{motion}` | Comment.nvim |
| Surround add | `ys{motion}{char}` | nvim-surround |
| Surround delete | `ds{char}` | nvim-surround |
| Surround change | `cs{old}{new}` | nvim-surround |
| Next buffer | `]b` | vim-unimpaired |
| Prev buffer | `[b` | vim-unimpaired |
| Next git hunk | `]h` | gitsigns |
| Prev git hunk | `[h` | gitsigns |
| Next function | `]f` | treesitter |
| Prev function | `[f` | treesitter |
| Select/expand | `<C-Space>` | treesitter |
| Swap param right | `<leader>a` | treesitter |
| Split code block | `gS` | splitjoin |
| Join code block | `gJ` | splitjoin |
| Find files | `<leader>ff` | telescope |
| Live grep | `<leader>fg` | telescope |
| Git status | `<leader>gs` | telescope |
| Toggle explorer | `<leader>e` | nvim-tree |
| Focus explorer | `<leader>o` | nvim-tree |
| Follow wiki link | `gf` | obsidian.nvim |
| Find note | `<leader>oo` | obsidian.nvim |
| Search notes | `<leader>os` | obsidian.nvim |
| Send to Claude | `<leader>cc` | (visual mode) |

---

## LSP (Language Server Protocol)

Provides IDE-like features: autocompletion, go to definition, diagnostics, etc.

### Navigation

```
gd                  Go to definition
gD                  Go to declaration
gr                  Find all references
gi                  Go to implementation
K                   Hover documentation (show type info)
```

### Actions

```
<leader>rn          Rename symbol (across all files)
<leader>ca          Code action (quick fixes, refactors)
<leader>d           Show diagnostic message in float
```

### Diagnostics (Errors/Warnings)

```
[d                  Previous diagnostic
]d                  Next diagnostic
```

### Autocompletion (nvim-cmp)

```
<Tab>               Next completion item / expand snippet
<S-Tab>             Previous completion item
<CR>                Confirm selection
<C-Space>           Trigger completion manually
<C-e>               Close completion menu
<C-b> / <C-f>       Scroll docs up/down
```

### Snippets

After selecting a snippet and pressing `<CR>`:

```
<Tab>               Jump to next placeholder
<S-Tab>             Jump to previous placeholder
```

### Installing Language Servers

Use Mason to install language servers:

```
:Mason              Open Mason UI
```

Then press `i` on any server to install it. Configured servers auto-install.

**Pre-configured servers:**
- TypeScript/JavaScript (`ts_ls`)
- Vue (`volar`)
- HTML, CSS, Tailwind
- JSON, YAML
- Lua, Python, Go, Rust
- PHP (`intelephense`)
- Bash

---

## Treesitter

Provides intelligent syntax highlighting, code navigation, and text objects based on actual code structure (not just regex patterns).

### Incremental Selection

```
<C-Space>           Start selection / expand to larger syntax node
<BS>                Shrink selection to smaller syntax node
```

**Example workflow:**
1. Cursor on `foo` in `myFunc(foo, bar)`
2. Press `<C-Space>` → selects `foo`
3. Press `<C-Space>` → selects `foo, bar`
4. Press `<C-Space>` → selects `(foo, bar)`
5. Press `<C-Space>` → selects entire function call
6. Press `<BS>` → shrinks back down

### Text Objects

Use with operators like `d`, `c`, `y`, `v`:

```
af / if             Around/inside function
ac / ic             Around/inside class
aa / ia             Around/inside argument/parameter
```

**Examples:**
```
daf                 Delete entire function
cif                 Change function body (keep signature)
yia                 Yank the parameter under cursor
vac                 Visual select entire class
daa                 Delete argument including comma
```

### Navigation

```
]f / [f             Next/previous function start
]c / [c             Next/previous class start
]a / [a             Next/previous argument
```

### Swap Parameters

```
<leader>a           Swap parameter with next
<leader>A           Swap parameter with previous
```

**Example:**
```javascript
// Cursor on 'first'
myFunc(first, second, third)

// Press <leader>a
myFunc(second, first, third)
```

### Context (sticky header)

The current function/class name stays visible at the top of the screen when you scroll down into a long function. This is automatic.

### Auto-close HTML Tags

When you type `>` to close an opening tag, the closing tag is auto-inserted:

```html
<div>|</div>        <!-- Cursor at | after typing <div> -->
```

Renaming a tag automatically renames its pair.

---

## Comment.nvim

**Mnemonic**: `gc` = "go comment"

### Basic Usage

```
gcc                 Comment/uncomment current line
gc{motion}          Comment/uncomment with motion
gbc                 Block comment current line
```

### Examples

```
gcc                 Toggle comment on current line
gc4j                Comment current line + 4 lines down
gcap                Comment around paragraph
gcip                Comment inside paragraph
gci{                Comment inside curly braces
gc%                 Comment to matching bracket
```

### Visual Mode

```
gc                  Comment selected lines (in visual mode)
gb                  Block comment selected lines
```

---

## nvim-surround

**Mnemonic**: `ys` = "you surround", `ds` = "delete surround", `cs` = "change surround"

### Add Surroundings (`ys`)

```
ys{motion}{char}    Surround motion with char
yss{char}           Surround entire line
yS{motion}{char}    Surround on new lines
```

### Examples - Adding

```
ysiw"               Surround word with "quotes"
                    hello → "hello"

ysiw'               Surround word with 'single quotes'
                    hello → 'hello'

ysiw)               Surround word with (parens) - no space
                    hello → (hello)

ysiw(               Surround word with ( parens ) - with space
                    hello → ( hello )

ysiw]               Surround word with [brackets] - no space
ys$"                Surround from cursor to end of line with "
yss)                Surround entire line with ()
ys2w"               Surround next 2 words with "
ysiW"               Surround WORD (includes punctuation) with "
```

### Delete Surroundings (`ds`)

```
ds{char}            Delete surrounding char
```

### Examples - Deleting

```
ds"                 Delete surrounding "quotes"
                    "hello" → hello

ds)                 Delete surrounding ()
                    (hello) → hello

dst                 Delete surrounding HTML tag
                    <div>hello</div> → hello
```

### Change Surroundings (`cs`)

```
cs{old}{new}        Change surrounding from old to new
```

### Examples - Changing

```
cs"'                Change " to '
                    "hello" → 'hello'

cs)]                Change ) to ]
                    (hello) → [hello]

cs)[                Change ) to [ with spaces
                    (hello) → [ hello ]

cst<div>            Change surrounding tag to <div>
                    <p>hello</p> → <div>hello</div>

cs"<em>             Change " to <em> tag
                    "hello" → <em>hello</em>
```

### Special Characters

| Char | Result |
|------|--------|
| `(` or `)` | Parentheses (with/without space) |
| `[` or `]` | Brackets (with/without space) |
| `{` or `}` | Braces (with/without space) |
| `<` or `>` | Angle brackets |
| `t` | HTML/XML tag |
| `'` `"` `` ` `` | Quotes |
| `f` | Function call: `func()` |

---

## vim-unimpaired

**Mnemonic**: `[` = previous/up, `]` = next/down

### Navigation

```
[b / ]b             Previous/next buffer
[q / ]q             Previous/next quickfix item
[l / ]l             Previous/next location list item
[t / ]t             Previous/next tag
[f / ]f             Previous/next file in directory
[n / ]n             Previous/next conflict marker
```

### Adding Blank Lines

```
[<Space>            Add blank line above
]<Space>            Add blank line below
```

### Moving Lines

```
[e                  Move line up (exchange)
]e                  Move line down (exchange)
```

### Toggling Options

```
[oh                 Enable hlsearch
]oh                 Disable hlsearch
yoh                 Toggle hlsearch

[on                 Enable line numbers
]on                 Disable line numbers
yon                 Toggle line numbers

[ow                 Enable wrap
]ow                 Disable wrap
yow                 Toggle wrap

[os                 Enable spell
]os                 Disable spell
yos                 Toggle spell
```

### Encoding/Decoding

```
[x{motion}          XML encode
]x{motion}          XML decode
[u{motion}          URL encode
]u{motion}          URL decode
```

---

## gitsigns.nvim

### Navigation

```
]h                  Next hunk
[h                  Previous hunk
```

### Actions (Leader = Space)

```
<leader>hs          Stage hunk
<leader>hr          Reset hunk (undo changes)
<leader>hp          Preview hunk (see what changed)
<leader>hb          Blame line (who wrote this?)
```

---

## splitjoin.vim

**Mnemonic**: `gS` = "go Split", `gJ` = "go Join"

### Basic Usage

```
gS                  Split one-liner into multiple lines
gJ                  Join multiple lines into one
```

### Examples

**JavaScript/TypeScript:**
```javascript
// Before gS:
const obj = { foo: 1, bar: 2, baz: 3 }

// After gS:
const obj = {
  foo: 1,
  bar: 2,
  baz: 3
}

// After gJ (reverses it):
const obj = { foo: 1, bar: 2, baz: 3 }
```

**HTML:**
```html
<!-- Before gS: -->
<div class="foo" id="bar">content</div>

<!-- After gS: -->
<div
  class="foo"
  id="bar"
>content</div>
```

---

## Telescope

### File Finding

```
<leader>ff          Find files (fuzzy search)
<leader>fg          Live grep (search in files)
<leader>fb          Find open buffers
<leader>fh          Help tags
<leader>gs          Git status
```

### Inside Telescope

```
<C-n> / <C-p>       Next/previous result
<C-j> / <C-k>       Next/previous result (alt)
<CR>                Open file
<C-x>               Open in horizontal split
<C-v>               Open in vertical split
<C-t>               Open in new tab
<Esc>               Close telescope
```

---

## obsidian.nvim

Navigate and search your Obsidian vault (`~/Obsidian`) directly in Neovim.

### Navigation

```
gf                  Follow [[wiki link]] under cursor
<leader>oo          Find note by name (Telescope)
<leader>os          Search note contents (Telescope)
<leader>ob          Show backlinks to current note
<leader>ot          Browse tags
<leader>on          Create new note
```

### Commands

```
:Obsidian open      Open current note in Obsidian app
:Obsidian new       Create a new note
:Obsidian search    Search notes by content
:Obsidian quick_switch  Find note by name
:Obsidian backlinks Show notes linking to this one
:Obsidian tags      Browse all tags
:Obsidian today     Open/create today's daily note
:Obsidian yesterday Open yesterday's daily note
```

---

## nvim-tree

```
<leader>e           Toggle file explorer
<leader>o           Toggle focus between explorer and editor
```

### Inside nvim-tree

```
<CR> or o           Open file/folder
a                   Create new file
d                   Delete file
r                   Rename file
x                   Cut
c                   Copy
p                   Paste
y                   Copy name
Y                   Copy relative path
gy                  Copy absolute path
q                   Close
R                   Refresh
H                   Toggle hidden files
?                   Help
```

---

## vim-tmux-navigator

Seamlessly navigate between vim and tmux panes:

```
<C-h>               Move to left pane/split
<C-j>               Move to pane/split below
<C-k>               Move to pane/split above
<C-l>               Move to right pane/split
```

Works the same in both vim and tmux!

**Tmux pane swapping** (prefix + key):

```
{                   Swap current pane with previous
}                   Swap current pane with next
```

---

## bufdelete.nvim

```
:Bdelete            Close buffer, keep window layout
:Bwipeout           Wipe buffer completely
```

Unlike `:bd`, this won't close your split windows.

---

## Claude Code Integration

Send visual selection to Claude Code running in another tmux pane:

```
<leader>cc          Send selection to Claude (visual mode)
```

The selection is sent with file context:
```
In `src/app.js:42-58`:
```javascript
// your selected code here
```
```

**Configure target pane** (optional, defaults to last pane):
```lua
vim.g.claude_tmux_pane = "{last}"   -- default: last active pane
vim.g.claude_tmux_pane = "{right}"  -- pane to the right
vim.g.claude_tmux_pane = ":.1"      -- pane 1 in current window
```

---

## Other Plugins (Automatic)

These work automatically, no keys to learn:

| Plugin | What it does |
|--------|--------------|
| **treesitter** | Syntax highlighting based on actual code parsing |
| **treesitter-context** | Shows current function/class at top when scrolled |
| **nvim-ts-autotag** | Auto-closes and renames HTML/JSX tags |
| **vim-sleuth** | Auto-detects indent settings (tabs vs spaces) |
| **vim-repeat** | Makes `.` work with plugin commands |
| **nvim-lastplace** | Restores cursor position when reopening files |
| **vim-visual-star-search** | Use `*` and `#` in visual mode to search selection |
| **vim-heritage** | Auto-creates parent directories when saving |
| **nvim-autopairs** | Auto-closes brackets, quotes, etc. |
| **neoscroll** | Smooth scrolling with `<C-d>`, `<C-u>`, etc. |
| **vim-pasta** | Context-aware pasting (correct indentation) |

---

## Vim Fundamentals (Quick Refresher)

### Motions

```
w / W               Next word / WORD
b / B               Back word / WORD
e / E               End of word / WORD
0 / $               Start / end of line
^ / g_              First / last non-blank
gg / G              Start / end of file
{ / }               Previous / next paragraph
%                   Matching bracket
f{char} / F{char}   Find char forward / backward
t{char} / T{char}   Till char forward / backward
; / ,               Repeat f/F/t/T forward / backward
```

### Text Objects

```
iw / aw             Inner word / a word (includes space)
is / as             Inner sentence / a sentence
ip / ap             Inner paragraph / a paragraph
i" / a"             Inner quotes / a quotes
i) / a)             Inner parens / a parens
i] / a]             Inner brackets / a brackets
i} / a}             Inner braces / a braces
it / at             Inner tag / a tag (HTML)
```

### Operators + Motions

```
d{motion}           Delete
c{motion}           Change (delete + insert mode)
y{motion}           Yank (copy)
v{motion}           Visual select
>/{motion}          Indent
<{motion}           Outdent
```

### Examples

```
diw                 Delete inner word
ciw                 Change inner word
yi"                 Yank inside quotes
da)                 Delete around parentheses
ci{                 Change inside braces
vap                 Visual select around paragraph
>ip                 Indent inner paragraph
```
