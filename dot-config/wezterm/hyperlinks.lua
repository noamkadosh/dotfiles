local wezterm = require("wezterm")

local M = {}

function M.default_hyperlinks_with(rules)
    local hyperlinks = wezterm.default_hyperlink_rules()

    for _, rule in ipairs(rules) do
        table.insert(hyperlinks, rule)
    end

    return hyperlinks
end

-- Linkify things that look like URLs with numeric addresses as hosts.
-- E.g. http://127.0.0.1:8000 for a local development server,
-- or http://192.168.1.1 for the web interface of many routers.
M.numeric_hyperlinks = {
    regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
    format = "$0",
}

-- Make task numbers clickable
-- The first matched regex group is captured in $1.
-- M.task_numbers = {
--     regex = [[\b[tT](\d+)\b]],
--     format = "https://example.com/tasks/?t=$1",
-- }

-- Make username/project paths clickable. This implies paths like the following are for GitHub.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | 'wez/wezterm.git' )
-- As long as a full URL hyperlink regex exists above this it should not match a full URL to
-- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
M.github_hyperlinks = {
    regex = [[["']?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["']?]],
    format = "https://www.github.com/$1/$3",
}

return M
