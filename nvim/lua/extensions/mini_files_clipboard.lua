local M = {}

local on_exit_file_copy = function(res, fs)
  if res.stderr and res.stderr ~= "" then
    vim.notify(res.stderr, vim.log.levels.ERROR)
    return
  end

  if fs.fs_type == "file" then
    vim.notify("Файл _" .. fs.name .. "_ скопирован")
  else
    vim.notify("Папка _" .. fs.name .. "_ скопирована")
  end
end

local copy_to_clipboard = function()
  local fs = MiniFiles.get_fs_entry()

  if not fs then
    vim.notify("Файл не найден", vim.log.levels.ERROR)
    return
  end

  vim.system({ "powershell.exe", "-Command", "Set-Clipboard", "-Path", fs.path }, nil, function(res)
    on_exit_file_copy(res, fs)
  end)
end

local copy_to_desktop = function()
  local fs = MiniFiles.get_fs_entry()
  if not fs then
    vim.notify("Файл не найден", vim.log.levels.ERROR)
    return
  end

  vim.system({ "cp", "-ir", fs.path, "~/Desktop/" }, nil, function(res)
    on_exit_file_copy(res, fs)
  end)
end

function M.setup()
  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      vim.keymap.set(
        "n",
        "<C-w>Y",
        copy_to_desktop,
        { buffer = args.data.buf_id, desc = "Скопировать на рабочий стол" }
      )

      vim.keymap.set(
        "n",
        "<C-w>y",
        copy_to_clipboard,
        { buffer = args.data.buf_id, desc = " Скопировать в буфер обмена" }
      )
    end,
  })
end

return M
