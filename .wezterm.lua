-- wezterm.log_error("Hello!")
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux
local act = wezterm.action

-- Defauls
config.default_prog = { "C:/Program Files/Git/bin/bash.exe", "-i", "-l" }
config.default_cwd = "D:projects"

-- Откртыть терминал на весь экран
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- Styles
config.color_scheme = "OneHalfDark"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.use_fancy_tab_bar = false

-- Повысить контрастность текста
-- config.foreground_text_hsb = {
-- 	hue = 1.0,
-- 	saturation = 1.2,
-- 	brightness = 1.5,
-- }

-- Font
adjust_window_size_when_changing_font_size = false
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.line_height = 1.2
config.font_size = 10

-- Tabs
config.tab_max_width = 100
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Показывать текущую директорию в названии вкладки
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local url = tab.active_pane.current_working_dir
	local path = url.path:gsub("[/]", "\\"):sub(2, -2)
	local cwd = (path == wezterm.home_dir and "~") or url.path:match("([^/\\]+)[/\\]$") or url.path
	return " " .. tab.tab_index + 1 .. ": " .. cwd .. " "
end)

local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

local function toogle_term()
	return {
		key = "/",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			local tab = pane:tab()
			local panes_with_info = tab:panes_with_info()

			local have_only_one = #tab:panes() == 1
			if have_only_one then
				pane:split({ direction = "Bottom" })
				return
			end

			local pane_is_zoomed = false
			for _, pane_info in ipairs(panes_with_info) do
				if pane_info.is_active then
					pane_is_zoomed = pane_info.is_zoomed
					break
				end
			end

			if pane_is_zoomed then
				tab:set_zoomed(false)
				window:perform_action({ ActivatePaneDirection = "Down" }, pane)
			else
				window:perform_action({ ActivatePaneDirection = "Up" }, pane)
				tab:set_zoomed(true)
			end
		end),
	}
end

-- config.disable_default_key_bindings = true
config.keys = {
	-- Clipboard
	{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	-- Managa tabs
	{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	-- Splits
	{ key = "v", mods = "ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "s", mods = "ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
	-- Neovim terminal
	toogle_term(),
}

return config
