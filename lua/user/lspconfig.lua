-- Use a protected call so we don't error out on first use
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local servers = {
	"html",
	"cssls",
	"tsserver",
	"vuels",
	-- "volar",
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Embedding on_attach function to all servers' setup...
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach
  }
end

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.html.setup {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = { css = true, javascript = true },
    provideFormatter = true
  },
  single_file_support = true,
}

lspconfig.cssls.setup {
  capabilities = capabilities,
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
}

lspconfig.vuels.setup {
  cmd = { "vls" },
  filetype = { "vue" },
  init_options = {
	  config = {
	    css = {},
	    emmet = {},
	    html = {
	      suggest = {}
	    },
	    javascript = {
	      format = {}
	    },
	    stylusSupremacy = {},
	    typescript = {
	      format = {}
	    },
	    vetur = {
	      completion = {
	        autoImport = false,
	        tagCasing = "kebab",
	        useScaffoldSnippets = false
	      },
	      format = {
	        defaultFormatter = {
	          js = "none",
	          ts = "none"
	        },
	        defaultFormatterOptions = {},
	        scriptInitialIndent = false,
	        styleInitialIndent = false
	      },
	      useWorkspaceDependencies = false,
	      validation = {
	        script = true,
	        style = true,
	        template = true
	      }
	    }
	  }
	}
}

-- lspconfig.volar.setup {
--   cmd = { "vue-language-server", "--stdio" },
--   filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
--   init_options = {
-- 	  documentFeatures = {
-- 	    documentColor = false,
-- 	    documentFormatting = {
-- 	      defaultPrintWidth = 100
-- 	    },
-- 	    documentSymbol = true,
-- 	    foldingRange = true,
-- 	    linkedEditingRange = true,
-- 	    selectionRange = true
-- 	  },
-- 	  languageFeatures = {
-- 	    callHierarchy = true,
-- 	    codeAction = true,
-- 	    codeLens = true,
-- 	    completion = {
-- 	      defaultAttrNameCase = "kebabCase",
-- 	      defaultTagNameCase = "both"
-- 	    },
-- 	    definition = true,
-- 	    diagnostics = true,
-- 	    documentHighlight = true,
-- 	    documentLink = true,
-- 	    hover = true,
-- 	    implementation = true,
-- 	    references = true,
-- 	    rename = true,
-- 	    renameFileRefactoring = true,
-- 	    schemaRequestService = true,
-- 	    semanticTokens = false,
-- 	    signatureHelp = true,
-- 	    typeDefinition = true
-- 	  },
-- 	  typescript = {
-- 	    tsdk = "/home/paulo/.nvm/versions/node/v14.19.3/bin/typescript-language-server"
-- 	  }
-- 	}
-- }

