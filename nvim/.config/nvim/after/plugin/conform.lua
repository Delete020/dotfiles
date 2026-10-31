local conform = require("conform")
conform.lazy = false

conform.setup({
	notify_on_error = false,
	--format_on_save = function(bufnr)
	--	-- Disable "format_on_save lsp_fallback" for languages that don't
	--	-- have a well standardized coding style. You can add additional
	--	-- languages here or re-enable it for the disabled ones.
	--	local disable_filetypes = { c = true, cpp = true }
	--	return {
	--		timeout_ms = 500,
	--		lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
	--	}
	--end,

	formatters_by_ft = {
		-- Lua
		lua = { "stylua" },
		
		-- Go
		go = { "goimports", "gofmt" },
		
		-- Python
		python = { "isort", "black" },
		
		-- JavaScript/TypeScript
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		
		-- Web technologies
		html = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		scss = { "prettierd", "prettier", stop_after_first = true },
		sass = { "prettierd", "prettier", stop_after_first = true },
		
		-- Data formats
		json = { "prettierd", "prettier", stop_after_first = true },
		jsonc = { "prettierd", "prettier", stop_after_first = true },
		yaml = { "prettierd", "prettier", stop_after_first = true },
		toml = { "taplo" },
		xml = { "xmlformat" },
		
		-- Markdown and documentation
		markdown = { "prettierd", "prettier", stop_after_first = true },
		
		-- Rust
		rust = { "rustfmt" },
		
		-- C/C++
		c = { "clang_format" },
		cpp = { "clang_format" },
		
		-- Shell scripts
		sh = { "shfmt" },
		bash = { "shfmt" },
		
		-- SQL
		sql = { "sqlfluff" },
		
		-- Docker
		dockerfile = { "hadolint" },
		
		-- Use the "*" filetype to run formatters on all filetypes.
		-- Use the "_" filetype to run formatters on filetypes that don't
		-- have other formatters configured.
		["_"] = { "trim_whitespace" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "[F]ormat buffer" })
