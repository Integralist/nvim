local export = {}

function export.on_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<c-]>', "<Cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
  vim.keymap.set('n', 'K', "<Cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
  vim.keymap.set('n', 'gh', "<Cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
  vim.keymap.set('n', 'ga', "<Cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
  vim.keymap.set('n', 'gm', "<Cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
  vim.keymap.set('n', 'gl', "<Cmd>lua vim.lsp.buf.incoming_calls()<CR>", bufopts)
  vim.keymap.set('n', 'gd', "<Cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
  vim.keymap.set('n', 'gr', "<Cmd>lua vim.lsp.buf.references()<CR>", bufopts)
  vim.keymap.set('n', 'gn', "<Cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
  -- vim.keymap.set('n', 'gs', "<Cmd>lua vim.lsp.buf.document_symbol()<CR>", bufopts)
  vim.keymap.set('n', 'gs', "<Cmd>SymbolsOutline<CR>", bufopts)
  vim.keymap.set('n', 'gw', "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>", bufopts)
  vim.keymap.set('n', '[x', "<Cmd>lua vim.diagnostic.goto_prev()<CR>", bufopts)
  vim.keymap.set('n', ']x', "<Cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
  vim.keymap.set('n', ']r', "<Cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
  vim.keymap.set('n', ']s', "<Cmd>lua vim.diagnostic.show()<CR>", bufopts)

  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup("SharedLspFormatting", { clear = true }),
    pattern = "*",
    command = "lua vim.lsp.buf.format()",
  })

  if client.server_capabilities.documentSymbolProvider then
    -- WARNING: ../plugins/lsp.lua must be loaded first to avoid error loading navic plugin.
    require("nvim-navic").attach(client, bufnr)

    vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, bg = "#000000", fg = "#83a598" })
    vim.api.nvim_set_hl(0, "NavicText", { default = true, bg = "#000000", fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, bg = "#000000", fg = "#fabd2f" })

    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end
end

return export
