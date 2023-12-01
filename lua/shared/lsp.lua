local function merge(t1, t2)
  for i = 1, #t2 do t1[#t1 + 1] = t2[i] end
  return t1
end

-- require("shared/lsp").on_attach
return function(client, bufnr)
  vim.api.nvim_create_autocmd({ "BufWrite" }, {
    callback = function(_)
      local namespace = vim.lsp.diagnostic.get_namespace(client.id)
      vim.diagnostic.setqflist({ namespace = namespace })
    end
  })

  local opts = { noremap = true, silent = true, buffer = bufnr }

  local buf_code_action = "<Cmd>lua vim.lsp.buf.code_action()<CR>"
  local buf_code_action_opts = merge({ desc = "View code actions" }, opts)
  local buf_def = "<Cmd>lua vim.lsp.buf.definition()<CR>"
  local buf_def_split = "<Cmd>sp | lua vim.lsp.buf.definition()<CR>"
  local buf_def_vsplit = "<Cmd>vsp | lua vim.lsp.buf.definition()<CR>"
  local buf_doc_sym = "<Cmd>lua vim.lsp.buf.document_symbol()<CR>"
  local buf_doc_sym_opts = merge({ desc = "List doc symbols in qf win" }, opts)
  local buf_hover = "<Cmd>lua vim.lsp.buf.hover()<CR>"
  local buf_impl = "<Cmd>lua vim.lsp.buf.implementation()<CR>"
  local buf_impl_opts = merge({ desc = "List all implementations" }, opts)
  local buf_incoming_calls = "<Cmd>lua vim.lsp.buf.incoming_calls()<CR>"
  local buf_incoming_calls_opts = merge({ desc = "List all callers" }, opts)
  local buf_project = "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>"
  local buf_project_opts = merge({ desc = "Search project-wide symbols" }, opts)
  local buf_ref = "<Cmd>lua vim.lsp.buf.references()<CR>"
  local buf_ref_opts = merge({ desc = "List all references" }, opts)
  local buf_rename = "<Cmd>lua vim.lsp.buf.rename()<CR>"
  local buf_rename_opts = merge({ desc = "Rename symbol" }, opts)
  local buf_sig_help = "<Cmd>lua vim.lsp.buf.signature_help()<CR>"
  local buf_sig_help_opts = merge({ desc = "Sig help (cursor over arg)" }, opts)
  local buf_type = "<Cmd>lua vim.lsp.buf.type_definition()<CR>"
  local buf_type_opts = merge({ desc = "Go to 'type' definition" }, opts)
  local diag_next = "<Cmd>lua vim.diagnostic.goto_next()<CR>"
  local diag_next_opts = merge({ desc = "Go to next diagnostic" }, opts)
  local diag_open_float = "<Cmd>lua vim.diagnostic.open_float()<CR>"
  local diag_open_float_opts = merge({ desc = "Float current diag" }, opts)
  local diag_prev = "<Cmd>lua vim.diagnostic.goto_prev()<CR>"
  local diag_prev_opts = merge({ desc = "Go to prev diagnostic" }, opts)
  local diag_show = "<Cmd>lua vim.diagnostic.show()<CR>"
  local diag_show_opts = merge({ desc = "Show project diagnostics" }, opts)

  vim.keymap.set('n', '<c-s>', buf_def_split, opts)
  vim.keymap.set('n', '<c-\\>', buf_def_vsplit, opts)
  vim.keymap.set('n', '<c-]>', buf_def, opts)
  vim.keymap.set('n', '[x', diag_prev, diag_prev_opts)
  vim.keymap.set('n', ']r', diag_open_float, diag_open_float_opts)
  vim.keymap.set('n', ']s', diag_show, diag_show_opts)
  vim.keymap.set('n', ']x', diag_next, diag_next_opts)
  vim.keymap.set('n', 'K', buf_hover, opts)
  vim.keymap.set('n', 'ga', buf_code_action, buf_code_action_opts)
  vim.keymap.set('n', 'gc', buf_incoming_calls, buf_incoming_calls_opts)
  vim.keymap.set('n', 'gd', buf_doc_sym, buf_doc_sym_opts)
  vim.keymap.set('n', 'gh', buf_sig_help, buf_sig_help_opts)
  vim.keymap.set('n', 'gi', buf_impl, buf_impl_opts)
  vim.keymap.set('n', 'gn', buf_rename, buf_rename_opts)
  vim.keymap.set('n', 'gp', buf_project, buf_project_opts)
  vim.keymap.set('n', 'gr', buf_ref, buf_ref_opts)
  vim.keymap.set('n', 'gy', buf_type, buf_type_opts)

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      group = vim.api.nvim_create_augroup("SharedLspFormatting",
        { clear = true }),
      pattern = "*",
      command = "lua vim.lsp.buf.format()"
    })
  end

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
    require("nvim-navbuddy").attach(client, bufnr)
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end
end
