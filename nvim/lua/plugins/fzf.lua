return {
  "ibhagwan/fzf-lua",
  opts = {
    fzf_colors = false,
    defaults = {
      formatter = "path.filename_first",
    },
    previewers = {
      builtin = {
        extensions = {
          -- -- neovim terminal only supports `viu` block output
          -- ["png"] = { "viu", "-b" },
          -- by default the filename is added as last argument
          -- if required, use `{file}` for argument positioning
          -- ["svg"] = { "chafa", "--colors=full", "--symbols=block", "{file}" },
          -- ["jpg"] = { "wezterm", "imgcat" },
          ["jpg"] = { "chafa", "-f", "symbols", "{file}" },
        },
        snacks_image = { enabled = true, render_inline = true },
      },
    },
  },
}
