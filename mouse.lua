local actions = {
	mssn_cntrl = function() hs.application.launchOrFocus('Mission Control') end,
	lft = function() hs.eventtap.keyStroke({}, 'Left') end,
	rght = function() hs.eventtap.keyStroke({}, 'Right') end,
	cmd_lft = function() hs.eventtap.keyStroke({'⌘'}, 'Left') end,
	cmd_rght = function() hs.eventtap.keyStroke({'⌘'}, 'Right') end,
	cmd_oe = function() hs.eventtap.keyStroke({'⌘'}, 'ö') end,
	cmd_ae = function() hs.eventtap.keyStroke({'⌘'}, 'ä') end,
	cmd_z = function() hs.eventtap.keyStroke({'⌘'}, 'z') end,
	shft_cmd_z = function() hs.eventtap.keyStroke({'shift','⌘'}, 'z') end,
	cmd_y = function() hs.eventtap.keyStroke({'⌘'}, 'y') end,
	void = function()end
}

local buttons = {
	middle = actions.mssn_cntrl,
	back = actions.cmd_lft,
	forwards = actions.cmd_rght
}

local mappings = {
	Blender = {
		middle = actions.void,
		back = actions.cmd_z,
		forwards = actions.shft_cmd_z },
	Safari = {
		middle = actions.mssn_cntrl,
		back = actions.cmd_oe,
		forwards = actions.cmd_ae },
	Finder = {
		middle = actions.mssn_cntrl,
		back = actions.lft,
		forwards = actions.rght },
	TextEdit = {
		middle = actions.mssn_cntrl,
		back = actions.cmd_z,
		forwards = actions.shft_cmd_z }
}

mappings.Kalender = mappings.Finder
mappings.Finder = mappings.iBooks
mappings.Unity = mappings.Blender
mappings.Godot = mappings.Blender
mappings.godot = mappings.Godot
mappings['Sublime Text'] = mappings.TextEdit
mappings['iA Writer'] = mappings.TextEdit
mappings.Typora = mappings.TextEdit
mappings.Pages = mappings.TextEdit
mappings.Numbers = mappings.TextEdit
mappings.Keynote = mappings.TextEdit
mappings.Keynote = mappings.TextEdit
mappings.Keynote = mappings.TextEdit
mappings['Affinity Designer'] = mappings.TextEdit
mappings['Affinity Photo'] = mappings.TextEdit
mappings['Affinity Publisher'] = mappings.TextEdit
mappings['InDesign CC'] = mappings.TextEdit
mappings['Illustrator CC'] = mappings.TextEdit

local mouse_click_event = hs.eventtap.new(
	{hs.eventtap.event.types.otherMouseDown},
	function(event)
		if event:getButtonState(2) then
			buttons.middle()
		elseif event:getButtonState(3) then
			buttons.back()
		elseif event:getButtonState(4) then
			buttons.forwards()
		end
	end)
:start()

return {
	map_to_application = function(app_name)
		if mappings[app_name] ~= nil then
			buttons.middle = mappings[app_name].middle
			buttons.back = mappings[app_name].back
			buttons.forwards = mappings[app_name].forwards
		else
			buttons.middle = actions.mssn_cntrl
			buttons.back = actions.cmd_lft
			buttons.forwards = actions.cmd_rght
		end
	end
}
