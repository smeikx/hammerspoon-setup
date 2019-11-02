local mappings = {
	default = {
		[3] = function() hs.eventtap.keyStroke({'⌘'}, 'Left') end,
		[4] = function() hs.eventtap.keyStroke({'⌘'}, 'Right') end
	},
	Finder = {
		[3] = function() hs.eventtap.keyStroke({}, 'Left') end,
		[4] = function() hs.eventtap.keyStroke({}, 'Right') end
	}
}

local mapping = {
	[3] = mappings.default[3], -- back
	[4] = mappings.default[4] -- forward
}

local current_app = ''

hs.eventtap.new({25}, -- otherMouseDown
	function(event)
		local button = event:getProperty(3)
		if button == 2 then -- middleClick
			if event:getProperty(1) == 2 then -- doubleClick
				hs.application.launchOrFocus('Mission Control')
				return true
			end
			return current_app == 'Terminal'
		end
		if event:getButtonState(button) then
			mapping[button]()
			return true
		end
	end)
:start()

local E = {} -- see “Save Navigation” in ”Programming in Lua (4ed)”
return {
	map_to_app = function(app_name)
		current_app = app_name
		mapping[3] = (mappings[app_name] or E)[3] or mappings.default[3]
		mapping[4] = (mappings[app_name] or E)[4] or mappings.default[4]
	end
}

