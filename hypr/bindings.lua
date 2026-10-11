-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

local home_bin = (os.getenv("HOME") or "") .. "/.local/bin"

-- Restore Omarchy menu on Super+/ (pre-4.0 custom binding).
-- Default SUPER+SLASH was monitor scaling up.
hl.unbind("SUPER + SLASH")
o.bind("SUPER + SLASH", "Omarchy menu", "omarchy-menu toggle")

-- Later pre-4.0 override used Ctrl+/ instead of Super+/.
o.bind("CTRL + SLASH", "Omarchy menu", "omarchy-menu toggle")

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Disable Omarchy default Super window move/resize (use Alt Aerospace binds instead).
-- Keeps Super workspace switch/move and Super arrow focus.
hl.unbind("SUPER + SHIFT + LEFT")
hl.unbind("SUPER + SHIFT + RIGHT")
hl.unbind("SUPER + SHIFT + UP")
hl.unbind("SUPER + SHIFT + DOWN")

hl.unbind("SUPER + code:20")
hl.unbind("SUPER + code:21")
hl.unbind("SUPER + SHIFT + code:20")
hl.unbind("SUPER + SHIFT + code:21")
hl.unbind("SUPER + ALT + code:20")
hl.unbind("SUPER + ALT + code:21")
hl.unbind("SUPER + SHIFT + ALT + code:20")
hl.unbind("SUPER + SHIFT + ALT + code:21")
hl.unbind("SUPER + CTRL + code:20")
hl.unbind("SUPER + CTRL + code:21")
hl.unbind("SUPER + CTRL + SHIFT + code:20")
hl.unbind("SUPER + CTRL + SHIFT + code:21")

hl.unbind("SUPER + mouse:272")
hl.unbind("SUPER + mouse:273")

-- Aerospace-style workspace shortcuts (macOS muscle memory).
-- Alt+N switches; Alt+Shift+N moves the window without following (Aerospace default).
-- Omarchy Super+N / Super+Shift+N bindings remain available.
for workspace = 1, 9 do
	local key = "code:" .. tostring(workspace + 9)
	o.bind("ALT + " .. key, "Switch to workspace " .. workspace, hl.dsp.focus({ workspace = tostring(workspace) }))
	o.bind(
		"ALT + SHIFT + " .. key,
		"Move window silently to workspace " .. workspace,
		hl.dsp.window.move({ workspace = tostring(workspace), follow = false })
	)
end

-- Alt+Tab: last two workspaces (Aerospace workspace-back-and-forth).
-- Was: focus next window / bring active window to top.
-- Window cycling remains on Alt+Shift+Tab; former workspace also on Super+Ctrl+Tab.
hl.unbind("ALT + TAB")
hl.unbind("ALT + TAB")
o.bind("ALT + TAB", "Former workspace", hl.dsp.focus({ workspace = "previous" }))

-- Aerospace-style directional focus (Alt+HJKL). Super+arrows remain available.
o.bind("ALT + H", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("ALT + J", "Focus on below window", hl.dsp.focus({ direction = "d" }))
o.bind("ALT + K", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("ALT + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))

-- Aerospace-style directional move (Alt+Shift+HJKL). Super+Shift+arrows remain available.
-- Note: Alt+Shift+L overrides the Chromium "Copy URL from Web App" shortcut at the compositor.
o.bind("ALT + SHIFT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("ALT + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("ALT + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("ALT + SHIFT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))

-- Aerospace-style resize width (Alt+-/=). Always adjusts width so left and
-- right columns behave the same; plain Hyprland resize reverses by side.
-- (Aerospace `smart` would switch to height inside a vertical stack.)
o.bind("ALT + MINUS", "Shrink window width", home_bin .. "/hypr-resize-smart -50 width", { repeating = true })
o.bind("ALT + EQUAL", "Expand window width", home_bin .. "/hypr-resize-smart +50 width", { repeating = true })

-- Alt+, zooms the focused window to the work area and keeps the bar and gaps.
-- Alt+/ zooms back out, then flips the split between stacked and side-by-side.
-- Closing a window can leave that split vertical. The flip runs after the
-- zoom-out, and again on a later press if the pair is already tiled.
-- xkbcommon names the comma keysym "comma"; "COMMA" does not match.
local function zoom_out_and_flip_split()
	hl.dispatch(hl.dsp.window.fullscreen({ mode = "maximized", action = "unset" }))
	hl.dispatch(hl.dsp.layout("togglesplit"))
end

o.bind("ALT + comma", "Maximize window", hl.dsp.window.fullscreen({ mode = "maximized", action = "set" }))
o.bind("ALT + SLASH", "Zoom out and flip split", zoom_out_and_flip_split)

-- Ctrl+Alt+Shift stands in for Super (Meta is consumed by keyd Cmd layer).
-- keyd may also translate this chord to Meta; either path should hit these actions.
-- Limitation: Super+Shift+* shortcuts cannot be typed with Shift used in the Super stand-in.
o.bind("CTRL + ALT + SHIFT + W", "Close window", hl.dsp.window.close())
o.bind("CTRL + ALT + SHIFT + RETURN", "Terminal", { omarchy = "terminal" })
o.bind("CTRL + ALT + SHIFT + SPACE", "Omarchy menu", "omarchy-menu toggle")
o.bind("CTRL + ALT + SHIFT + SLASH", "Omarchy menu", "omarchy-menu toggle")
o.bind("CTRL + ALT + SHIFT + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")
o.bind("CTRL + ALT + SHIFT + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind("CTRL + ALT + SHIFT + T", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))
o.bind("CTRL + ALT + SHIFT + S", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))
o.bind("CTRL + ALT + SHIFT + ESCAPE", "System menu", "omarchy-menu toggle system")
o.bind("CTRL + ALT + SHIFT + LEFT", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("CTRL + ALT + SHIFT + RIGHT", "Focus on right window", hl.dsp.focus({ direction = "r" }))
o.bind("CTRL + ALT + SHIFT + UP", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("CTRL + ALT + SHIFT + DOWN", "Focus on below window", hl.dsp.focus({ direction = "d" }))
for workspace = 1, 9 do
	local key = "code:" .. tostring(workspace + 9)
	o.bind(
		"CTRL + ALT + SHIFT + " .. key,
		"Switch to workspace " .. workspace,
		hl.dsp.focus({ workspace = tostring(workspace) })
	)
end

-- OmaKeys: Vimac-style click hints + keyboard grid mouse.
-- Requires `omakeys daemon` (started from autostart.lua).
o.bind("ALT + SEMICOLON", "OmaKeys hints", home_bin .. "/omakeys hints")
o.bind("ALT + SHIFT + SEMICOLON", "OmaKeys grid", home_bin .. "/omakeys toggle")
