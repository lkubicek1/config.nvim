# config.nvim

## Keymappings

Leader key: `<Space>`

Local leader key: `<Space>`

### Core mappings (`lua/keymaps.lua`)

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<Esc>` | Clear search highlighting (`:nohlsearch`) |
| Normal | `<leader>e` | Open diagnostic float |
| Normal | `<leader>q` | Open diagnostic location list |
| Normal | `[d` | Jump to previous diagnostic (with float) |
| Normal | `]d` | Jump to next diagnostic (with float) |
| Normal, Visual | `<leader>y` | Yank to system clipboard |
| Normal, Visual | `<leader>p` | Paste from system clipboard (after cursor) |
| Normal, Visual | `<leader>P` | Paste from system clipboard (before cursor) |
| Normal | `<A-j>` | Move current line down |
| Normal | `<A-k>` | Move current line up |
| Visual | `<A-j>` | Move selected block down |
| Visual | `<A-k>` | Move selected block up |
| Terminal | `<Esc><Esc>` | Exit terminal mode (`<C-\\><C-n>`) |
| Normal | `<C-h>` | Focus left split |
| Normal | `<C-l>` | Focus right split |
| Normal | `<C-j>` | Focus lower split |
| Normal | `<C-k>` | Focus upper split |

### LSP mappings (buffer-local on `LspAttach` in `lua/keymaps.lua`)

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `gd` | Go to definition |
| Normal | `gD` | Go to declaration |
| Normal | `gr` | Go to references |
| Normal | `gi` | Go to implementation |
| Normal | `<leader>D` | Go to type definition |
| Normal | `K` | Hover documentation |
| Normal | `<leader>rn` | Rename symbol |
| Normal, Visual | `<leader>ca` | Code action |

### Completion mappings (`lua/plugins/completion.lua`)

These are active while using `nvim-cmp` in Insert mode (Tab keys also apply to Select mode for snippets).

| Mode | Key | Action |
| --- | --- | --- |
| Insert | `<C-b>` | Scroll completion docs up |
| Insert | `<C-f>` | Scroll completion docs down |
| Insert | `<C-Space>` | Trigger completion menu |
| Insert | `<C-e>` | Abort completion |
| Insert | `<CR>` | Confirm selected completion item |
| Insert, Select | `<Tab>` | Next completion item, or expand/jump snippet |
| Insert, Select | `<S-Tab>` | Previous completion item, or jump snippet backward |

### Copilot suggestion mappings (`lua/plugins/copilot.lua`)

These are active for inline Copilot suggestions in Insert mode.

| Mode | Key | Action |
| --- | --- | --- |
| Insert | `<C-j>` | Accept Copilot suggestion |
| Insert | `<C-]>` | Dismiss Copilot suggestion |
