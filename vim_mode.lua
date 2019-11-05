local in_vim_mode = false
local function toggle_vim_mode()
	in_vim_mode = not in_vim_mode
	hs.alert(in_vim_mode and 'Vim ON' or 'Vim OFF')
end

local function press_key(mods, key)
	hs.eventtap.keyStroke(mods, key, 0)
end

local keycodes = hs.keycodes.map
local mappings = {
	[keycodes.h] = 'left',
	[keycodes.j] = 'down',
	[keycodes.k] = 'up',
	[keycodes.l] = 'right'
}

local all_mods = { 'shift', 'ctrl', 'alt', 'cmd' }
-- takes result from hs.eventtap.checkKeyboardModifiers() as argument
local function mod_table(mods)
	local mod_table = {}
	for _, mod in pairs(all_mods) do
		if mods[mod] then
			mod_table[#mod_table + 1] = mod
		end
	end
	return mod_table
end

local keycode_property = hs.eventtap.event.properties.keyboardEventKeycode
hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
	local mods = hs.eventtap.checkKeyboardModifiers()
	local keycode = e:getProperty(keycode_property)
	if mods['alt'] and keycode == 53 then
		toggle_vim_mode()
		return true
	elseif in_vim_mode and mappings[keycode] then
		press_key(mod_table(mods), mappings[keycode])
		return true
	end
end):start()
