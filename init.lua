require 'battery'
require 'window'
escape_app_toggle = require 'escape_app_toggle'
mouse = require 'mouse'

app_watcher = hs.application.watcher.new(
	function(app_name, event_type, _)
		if event_type == hs.application.watcher.activated then
			mouse.map_to_application(app_name)
		end
	end)
	:start()

escape_app_toggle.init("Terminal")
