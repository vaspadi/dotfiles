--- @param identifier string
function add_visual_surrond(identifier)
  return { identifier, "<cmd>normal gsa" .. identifier .. "<CR>", mode = "v" }
end

return {
  "nvim-mini/mini.surround",
  keys = {
    add_visual_surrond("'"),
    add_visual_surrond('"'),
    add_visual_surrond("{"),
    add_visual_surrond("("),
    add_visual_surrond("["),
    add_visual_surrond("<"),
  },
}
