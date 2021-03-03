local awful = require("awful")
local wibox = require("wibox")

local temp_widget = {}

local function worker(user_args)
    local args = user_args or {}

    temp_widget = wibox.widget{
        command = 'bash -c "sensors | grep Tctl", 15',
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.watch
    }

    return temp_widget
end
return setmetatable(temp_widget, { __call = function(_, ...)
    return worker(...)
end })

-- local watch = require("awful.widget.watch")
-- local wibox = require("wibox")
-- 
-- local function colorize(temp)
--   if temp < 30 then
--     return '#368893'
--   elseif temp < 60 then
--     return '#A5FF7F'
--   elseif temp < 75 then
--     return '#BC2F1D'
--   else
--     return '#FF891B'
--   end
-- end
-- 
-- local HOME_DIR = os.getenv("HOME")
-- local WIDGET_DIR = HOME_DIR .. '/.config/awesome/awesome-wm-widgets/temp-widget'
-- 
-- local temp_widget = {}
-- 
-- local function worker(user_args)
--     local args = user_args or {}
-- 
--     temp_widget = wibox.widget{
--         -- markup = bash -c "sensors | grep Tctl", 15,
--         markup = 'This <i>is</i> a <b>textbox</b>!!!',
--         align  = 'center',
--         valign = 'center',
--         widget = wibox.widget.textbox
--     }
-- 
--     return temp_widget
-- end
-- return setmetatable(temp_widget, { __call = function(_, ...)
--     return worker(...)
-- end })

--    markup = 'This <i>is</i> a <b>textbox</b>!!!',
--    temp_widget = awful.widget.watch(tempcommand, 5, function(widget, stdout)
--     for line in stdout:gmatch('[^\r\n]+') do
--       local temp = math.floor(tonumber(line) / 1000)
--       widget.markup = 'Cpu: ' .. markup(colorize(temp), tostring(temp)) .. '°C'
--     end
--    end)
--    temp_widget = wibox.widget {
--        markup = 'bash -c "sensors | grep Tctl"', 15,
--        text = "text test"
--        align  = 'center',
--        valign = 'center',
--        widget = wibox.widget.watch()
--    }
--    cpu_widget = wibox.widget {
--        {
--            cpugraph_widget,
--            reflection = {horizontal = true},
--            layout = wibox.container.mirror
--        },
--        bottom = 2,
--        widget = wibox.container.margin
--    }
