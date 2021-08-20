-- userconf.lua

local settings = require("settings")
local lousy = require("lousy")
local completion = require("completion")
local keysym = require("keysym")

-- Why is google the default luakit? WHY?
settings.window.default_search_engine = "duckduckgo"

-- Cookie acceptance policy
-- never, no_third_party(default), always
soup.accept_policy = "never"

-- Do not add to history
local history = require("history")
history.add = function(uri, title, update_visits)
	-- do nothing
end

-- Tab number
lousy.widget.tab.label_format = '<span foreground="{index_fg}" font="Monospace">{index} </span>{title}'
