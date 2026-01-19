local map = vim.keymap.set
local del = vim.keymap.del

del("n", "<leader>gd")

-- <windows>
map("n", "<leader>wh", "<C-w>H", { remap = true, desc = "Move window to far left" })
map("n", "<leader>wj", "<C-w>J", { remap = true, desc = "Move window to far bottom" })
map("n", "<leader>wk", "<C-w>K", { remap = true, desc = "Move window to far top" })
map("n", "<leader>wl", "<C-w>L", { remap = true, desc = "Move window to far right" })
-- </windows

-- <other>
map("n", "U", "<C-r>")

map("n", "<leader>gh", function()
  require("fzf-lua").git_bcommits()
end, { desc = "File History (fzf-lua)" })
-- </other>
