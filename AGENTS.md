# Neovim Configuration

Personal Neovim configuration focused on Go and Rust development,
using lazy.nvim for plugin management. Targets Neovim 0.12+.

## Repo Structure

```txt
init.lua                  — Bootstrap lazy.nvim, load core modules
lua/
  settings.lua            — vim.opt / vim.g settings
  mappings.lua            — Global keymaps (<leader> is \)
  autocommands.lua        — Autocmds (filetype, highlight, etc.)
  commands.lua            — Custom :commands
  quickfix.lua            — Quickfix list enhancements
  highlights.lua          — Highlight group overrides
  icons.lua               — Shared icon definitions
  custom/                 — Non-plugin utility modules
  plugins/                — lazy.nvim plugin specs (one per concern)
    lsp.lua               — LSP orchestration (Rust, generic)
    lsp/golang.lua        — gopls-specific config
    lint-and-format.lua   — conform.nvim + nvim-lint
    autocomplete.lua      — blink.cmp
    search.lua            — Telescope
    ...
after/ftplugin/           — Per-filetype overrides (sourced last)
ftdetect/                 — Custom filetype detection
spell/                    — Custom dictionary (zg to add words)
syntax/                   — Custom syntax rules (e.g. quickfix)
```

## Plugin Management

Uses [lazy.nvim](https://lazy.folke.io). Plugins are auto-discovered
from `lua/plugins/*.lua`. Each file returns a table (or list of
tables) following the lazy.nvim spec format.

Pin versions via `lazy-lock.json` (committed). Update plugins:

```bash
nvim --headless "+Lazy update" +qa
```

## LSP

LSP servers are configured via the Neovim 0.11+ `vim.lsp.config` /
`vim.lsp.enable` API (not nvim-lspconfig). Language-specific setup
lives in `lua/plugins/lsp/` modules called from the main
`lua/plugins/lsp.lua`.

Key LSP details:

- **Go**: gopls (v0.22+). Semantic tokens, codelens, gofumpt
  enabled. Imports handled by goimports-reviser via conform.nvim,
  not gopls.
- **Rust**: rustaceanvim (manages rust-analyzer lifecycle).
- **Completions**: blink.cmp provides capabilities to all servers.
- **Formatting**: conform.nvim (not LSP format on save).
- **Linting**: nvim-lint (golangci-lint, etc.).
- **Diagnostics**: tiny-inline-diagnostic.nvim (virtual_text
  disabled at the LSP level).

## Conventions

- Plugin specs are grouped by concern (one file = one category),
  not one file per plugin.
- `lazy.nvim` doesn't support requiring sibling modules from within
  `lua/plugins/` — nested modules go under subdirectories
  (e.g. `lua/plugins/lsp/golang.lua`).
- `<leader>` is `\`. Single leader = search actions. Double leader
  = other actions. See which-key for discovery.

## Gotchas

- `formatprg` is explicitly unset in the Go on_attach because
  Neovim 0.11+ sets it to `gofmt`, which breaks the `gq` motion.
- gopls `buildFlags` includes `-tags=e2e,issuance` — without this,
  `go list` fails in repos using custom build tags.
- illuminate plugin auto-attaches via cursor events; do NOT call
  `require("illuminate").on_attach()` manually.

## Debugging LSP (headless)

Inspect capabilities or runtime state without opening a full editor:

```bash
# Inspect a Lua value
nvim --headless -c 'lua print(vim.inspect(
  vim.lsp.protocol.make_client_capabilities().textDocument.semanticTokens
))' -c 'qa'

# Wait for gopls to attach, then inspect server capabilities
nvim --headless -c 'edit /tmp/test.go' -c 'lua vim.defer_fn(function()
  for _, c in ipairs(vim.lsp.get_clients({name="gopls"})) do
    print(vim.inspect(c.server_capabilities.semanticTokensProvider))
  end
  vim.cmd("qa")
end, 5000)' 2>&1

# Run health checks to a file
nvim --headless '+checkhealth vim.deprecated' '+w! /tmp/out.txt' '+qa'
```
