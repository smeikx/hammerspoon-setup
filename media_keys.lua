local cmus = {
	toggle_play = function() hs.execute('cmus-remote -u', true) end,
	previous = function() hs.execute('cmus-remote -r', true) end,
	next = function() hs.execute('cmus-remote -n', true) end
}

local itunes = {
	toggle_play = function() print('play') hs.itunes:playpause() end,
	previous = function() hs.itunes:previous() end,
	next = function() hs.itunes:next() end
}

local player = cmus

local on_media_key = hs.eventtap.new(
	{hs.eventtap.event.types.NSSystemDefined},
	function(event)
		local sysKeyData = event:systemKey()
		if next(sysKeyData) == nil or
			sysKeyData.repeating or
			not sysKeyData.down then
			return
		end
		if sysKeyData.key == 'FAST' then
			player.next()
		elseif sysKeyData.key == 'PLAY' then
			player.toggle_play()
		elseif sysKeyData.key == 'REWIND' then
			player.previous()
		end
	end)
:start()

return {
	deactivate_cmus = function()
		on_media_key:stop()
	end,
	activate_cmus = function()
		on_media_key:start()
	end
}
