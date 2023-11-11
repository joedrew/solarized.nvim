local M = {}

--- Get the solarized colors based on the current Vim background setting
---
--- @return table colors   A table containing the solarized colors
function M.get_colors()
  local dark = {
    base04 = '#103c48', -- background tone darker (column/nvim-tree)
    base03 = '#103c48', -- background tone dark (main)
    base02 = '#2d5b69', -- background tone (highlight/menu/LineNr)
    base01 = '#72898f', -- content tone (comment)
    base00 = '#cad8d9', -- content tone (winseparator)
    base0 = '#adbcbc', -- content tone (foreground)
    base1 = '#cad8d9', -- content tone (statusline/tabline)
    base2 = '#2d5b69', -- background tone light (highlight)
    base3 = '#2d5b69', -- background tone lighter (main)
    -- accent
    yellow = '#dbb32d',
    orange = '#ed8649',
    red = '#fa5750',
    magenta = '#f275be',
    violet = '#af88eb',
    blue = '#4695f7',
    cyan = '#41c7b9',
    green = '#75b938',
  }

  local light = {
    base3 = '#d5cdb6', -- background tone darker (main)
    base2 = '#d5cdb6', -- background tone dark (highlight)
    base1 = '#3a4d53', -- content tone (statusline/tabline)
    base0 = '#53676d', -- content tone (foreground)
    base00 = '#3a4d53', -- content tone (winseparator)
    base01 = '#909995', -- content tone (comment)
    base02 = '#ece3cc', -- background tone (highlight/menu/LineNr)
    base03 = '#fbf3db', -- background tone lighter (main)
    base04 = '#fbf3db', -- background tone (column/nvim-tree)
    -- accent
    yellow = '#ad8900',
    orange = '#c25d1e',
    red = '#d2212d',
    magenta = '#ca4898',
    violet = '#8762c6',
    blue = '#0072d4',
    cyan = '#009c8f',
    green = '#489100',
  }

  local ret

  if vim.o.background == 'dark' then
    ret = dark
  else
    ret = light
  end

  local special = {
    -- git
    add = ret.green,
    change = ret.yellow,
    delete = ret.red,
    -- diagnostic
    info = ret.blue,
    hint = ret.green,
    warning = ret.yellow,
    error = ret.red,
  }

  return vim.tbl_extend('error', ret, special)
end

--- Filter colors by selecting valid hexadecimal color values.
---
--- @param colors table A table containing color values to be filtered.
--- @return table Filtered colors table, containing only valid hexadecimal color values.
local function filter_colors(colors)
  local filtered_colors = {}

  for color_name, color_value in pairs(colors) do
    if string.match(color_value, '#%x%x%x%x%x%x$') then
      filtered_colors[color_name] = color_value
    elseif string.match(color_value, '#%x%x%x$') then
      color_value = string.sub(color_value, 2, #color_value)
      filtered_colors[color_name] = '#' .. string.rep(color_value, 2)
    end
  end

  return filtered_colors
end

--- Merge custom colors with solarized default colors
---
--- @param colors table A table containing new color values to be added.
--- @param custom_colors table
function M.extend_colors(colors, custom_colors)
  local c = vim.deepcopy(colors)
  custom_colors = filter_colors(custom_colors)

  return vim.tbl_extend('force', c, custom_colors)
end

return M
