local wezterm = require 'wezterm'
local act = wezterm.action

local module = {}

function module.apply_to_config(config)
   -- use command instead of control
   local new_keys = {}
   for _, v in ipairs(config.keys) do
      if v.mods == 'CTRL' then
         v.mods = 'CMD'
      elseif v.mods == 'CTRL|SHIFT' then
         v.mods = 'CMD|SHIFT'
      end
      table.insert(new_keys, v)
   end
   -- use cmd-c as control-c
   table.insert(
      new_keys,
      {
         key = 'c',
         mods = 'CMD',
         action = act.SendKey{ key = 'c', mods = 'CTRL'}
      }
   )

   config.keys = new_keys

   -- increase font size from default
   config.font_size = 14
end

return module
