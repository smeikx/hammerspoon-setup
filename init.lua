require 'battery'
require 'window'
mouse = require 'mouse'

app_watcher = hs.application.watcher.new(
	function(app_name, event_type, _)
		if event_type == hs.application.watcher.activated then
			mouse.map_to_application(app_name)
		end
	end)
	:start()

do
	local last_app = hs.application.frontmostApplication()
	local function toggle_alacritty()
		if hs.application.frontmostApplication():name() == 'Alacritty' then
			last_app:activate(false)
		else
			last_app = hs.application.frontmostApplication()
			hs.application.launchOrFocus('Alacritty')
		end
	end
	hs.hotkey.bind({'cmd'}, 'escape', nil, toggle_alacritty, nil, nil)
end
