local awful = require("awful")
local wibox = require("wibox")

local function colorize(temp)
  if temp < 30 then
    return '#368893'
  elseif temp < 60 then
    return '#A5FF7F'
  elseif temp < 75 then
    return '#BC2F1D'
  else
    return '#FF891B'
  end
end

local tempcommand = 'cat /sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon0/temp1_input'

local HOME_DIR = os.getenv("HOME")
local WIDGET_DIR = HOME_DIR .. '/.config/awesome/awesome-wm-widgets/cpu-widget'


local temp_widget = {}

local function worker(user_args)
    local args = user_args or {}

    temp_widget = awful.widget.watch(tempcommand, 5, function(widget, stdout)
     for line in stdout:gmatch('[^\r\n]+') do
       local temp = math.floor(tonumber(line) / 1000)
       widget.markup = 'Cpu: ' .. markup(colorize(temp), tostring(temp)) .. '°C'
     end
    end)
    -- temp_widget = wibox.widget {
    --     markup = 'bash -c "sensors | grep temp1"', 15,
    --     align  = 'center',
    --     valign = 'center',
    --     widget = wibox.widget.watch()
    -- }

    return temp_widget
end
return setmetatable(temp_widget, { __call = function(_, ...)
    return worker(...)
end })
