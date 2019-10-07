-- https://gist.github.com/asmagill/c38f75fff9d9ef43d1226329fc1436e4
-- the above version is nicely commented

local alert = hs.alert
local timer = hs.timer
local eventtap = hs.eventtap
local events = eventtap.event.types


timeFrame = 1 -- in seconds

action = function() -- what to do
	hs.application.launchOrFocus('Mission Control')
end

local timeFirstControl, firstDown, secondDown = 0, false, false

local noFlags = function(ev)
	local result = true
	for k,v in pairs(ev:getFlags()) do
		if v then
			result = false
			break
		end
	end
	return result
end


local onlyCtrl = function(ev)
	local result = ev:getFlags().ctrl
	for k,v in pairs(ev:getFlags()) do
		if k ~= "ctrl" and v then
			result = false
			break
		end
	end
	return result
end


eventtap.new({events.flagsChanged, events.keyDown}, function(ev)
	if (timer.secondsSinceEpoch() - timeFirstControl) > timeFrame then
		timeFirstControl, firstDown, secondDown = 0, false, false
	end

	if ev:getType() == events.flagsChanged then
		if noFlags(ev) and firstDown and secondDown then
			action()
			timeFirstControl, firstDown, secondDown = 0, false, false
		elseif onlyCtrl(ev) and not firstDown then
			firstDown = true
			timeFirstControl = timer.secondsSinceEpoch()
		elseif onlyCtrl(ev) and firstDown then
			secondDown = true
		elseif not noFlags(ev) then
			timeFirstControl, firstDown, secondDown = 0, false, false
		end
	else
		timeFirstControl, firstDown, secondDown = 0, false, false
	end
	return false
end):start()

