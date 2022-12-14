local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
  use { "wbthomason/packer.nvim" }              -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" }               -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs" }               -- Autopairs, integrates with both cmp and treesitter
  use { "kyazdani42/nvim-web-devicons" }        -- Web dev icons
  use { "kyazdani42/nvim-tree.lua" }            -- Nvim Tree
  use { "akinsho/bufferline.nvim" }             -- Bufferline
  use { "moll/vim-bbye" }                       -- BBye
	-- Colorschemes
  use { "folke/tokyonight.nvim" }
  use { "savq/melange" }
  use { "sainnhe/sonokai" }
  use { "sainnhe/everforest" }

	-- Cmp 
  use { "hrsh7th/nvim-cmp" }                    -- The completion plugin
  use { "hrsh7th/cmp-buffer" }                  -- buffer completions
  use { "hrsh7th/cmp-path" }                    -- path completions
  use { "hrsh7th/cmp-cmdline" }                 -- Command Line completions
	use { "saadparwaiz1/cmp_luasnip" }            -- Snippet completions
	use { "hrsh7th/cmp-nvim-lsp" }
	use { "hrsh7th/cmp-nvim-lua" }
  
  -- Snippets
  use { "L3MON4D3/LuaSnip" }                    -- Snippet engine
  use { "rafamadriz/friendly-snippets" }        -- A bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig" }
  use { "folke/lsp-colors.nvim" }

  -- Comments
  use { "numToStr/Comment.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }

	-- Telescope
  use { "nvim-telescope/telescope.nvim" } 

	-- Treesitter
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate"	}

	-- Git
  use { "lewis6991/gitsigns.nvim" }

  -- Lualine
  use { "nvim-lualine/lualine.nvim" }
  use { "arkav/lualine-lsp-progress" }

  -- NULL-LS
  use { "jose-elias-alvarez/null-ls.nvim" }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
