hs.hotkey.bind({'shift', 'ctrl'}, 'a', function()
	local win = hs.window.focusedWindow()
	local f = hs.screen.mainScreen():frame()
	local w, h = f.w / 5 * 3, f.h / 7 * 6
	f.x = (f.w - w) / 2
	f.y = (f.h - h) / 2
	f.h = h
	f.w = w
	win:setFrameInScreenBounds(f, 0.1)
end)

hs.hotkey.bind({}, 'f5', function()
	local win = hs.window.focusedWindow()
	local f = hs.screen.mainScreen():frame()
	f.w = f.w / 2
	win:setFrameInScreenBounds(f, 0.1)
end)

hs.hotkey.bind({}, 'f6', function()
	local win = hs.window.focusedWindow()
	local f = hs.screen.mainScreen():frame()
	f.w = f.w / 2
	f.x = f.w
	win:setFrameInScreenBounds(f, 0.1)
end)
