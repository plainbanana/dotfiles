local wezterm = require 'wezterm'
local act = wezterm.action

wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(window:active_workspace())
end)

-- This event fires when user vars are changed
-- We use it to update the window configuration 
-- Add an next line to your .bashrc to set an iTerm2 UserVar
--     printf "\033]1337;SetUserVar=%s=%s\007" production `echo -n 1 | base64`
-- c.f. https://github.com/wez/wezterm/issues/1680
wezterm.on("update-right-status", function(window, pane)
    local overrides = {}
    if pane:get_user_vars().production == "1" then
        overrides.color_scheme = "Sakura"
    end
    window:set_config_overrides(overrides)
end)

local config = {
    use_ime = true,
    font_size = 15.5,
    color_scheme = 'Solarized (light) (terminal.sexy)',
    adjust_window_size_when_changing_font_size = false,
    text_blink_rate = 0,
}

config.font = wezterm.font_with_fallback {
    {
        family = 'UDEV Gothic 35NFLG',
        weight = 'Medium',
        harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    },
    { family = 'Terminus', weight = 'Bold' },
    'Noto Color Emoji',
}

config.keys = {
    -- Move active tabs relatively.
    { key = 'LeftArrow', mods = 'SUPER', action = act.ActivateTabRelative(-1) },
    { key = 'RightArrow', mods = 'SUPER', action = act.ActivateTabRelative(1) },

    -- Clears only the scrollback and leaves the viewport intact.
    -- You won't see a difference in what is on screen, you just won't
    -- be able to scroll back until you've output more stuff on screen.
    -- This is the default behavior.
    {
        key = 'k',
        mods = 'SUPER',
        action = act.ClearScrollback 'ScrollbackOnly',
    },
    -- Clears the scrollback and viewport leaving the prompt line the new first line.
    {
        key = 'k',
        mods = 'SUPER',
        action = act.ClearScrollback 'ScrollbackAndViewport',
    },
    -- Clears the scrollback and viewport, and then sends CTRL-L to ask the
    -- shell to redraw its prompt
    {
        key = 'k',
        mods = 'SUPER',
        action = act.Multiple {
            act.ClearScrollback 'ScrollbackAndViewport',
            act.SendKey { key = 'L', mods = 'CTRL' },
        },
    },
    -- Switch workspace relatively.
    {
        key = 'f',
        mods = 'ALT',
        action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
    { key = 'c', mods = 'ALT', action = act.SwitchWorkspaceRelative(1) },
    { key = 'v', mods = 'ALT', action = act.SwitchWorkspaceRelative(-1) },
}

return config
