return {
	init = function(app_name)
		local last_app = hs.application.frontmostApplication()
		local function toggle_app()
			if hs.application.frontmostApplication():name() == app_name then
				last_app:activate(false)
			else
				last_app = hs.application.frontmostApplication()
				hs.application.launchOrFocus(app_name)
			end
		end
		hs.hotkey.bind({'cmd'}, 'escape', nil, toggle_app, nil, nil)
	end
}
