vim.keymap.set("n", "<A-;>", function() require('Comment.api').toggle.linewise.current() end, { noremap = true, silent = true })
