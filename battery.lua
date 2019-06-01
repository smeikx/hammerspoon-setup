-- https://www.wired.com/2013/09/laptop-battery/

local LIMITS = {
	first_low = 35,
	last_low = 30,
	first_high = 85,
	last_high = 90
}

local send_first_high_warning = true
local send_last_high_warning = true
local send_first_low_warning = true
local send_last_low_warning = true

local function check_percentage()

	local percentage = hs.battery.percentage()
	local charging = hs.battery.powerSource() ~= 'Battery Power'

	--[[ Debug
	print('send_first_high_warning: ' .. ((send_first_high_warning and 'true') or 'false'))
	print('send_last_high_warning: ' .. ((send_last_high_warning and 'true') or 'false'))
	print('send_first_low_warning: ' .. ((send_first_low_warning and 'true') or 'false'))
	print('send_last_low_warning: ' .. ((send_last_low_warning and 'true') or 'false'))
	print('percentage: ' .. percentage)
	print('charging: ' .. ((charging and 'true') or 'false'))
	print('#########################################')
	]]--

	if not charging then
		if send_first_low_warning and percentage <= LIMITS.first_low then
			warn_first_low()
			send_first_low_warning = false
		elseif send_last_low_warning and percentage <= LIMITS.last_low then
			warn_last_low()
			send_last_low_warning = false
		elseif percentage >= LIMITS.last_high then
			send_last_high_warning = true
		else
			send_first_high_warning = true
		end
	else
		if send_first_high_warning and percentage >= LIMITS.first_high then
			warn_first_high()
			send_first_high_warning = false
		elseif send_last_high_warning and percentage >= LIMITS.last_high then
			warn_last_high()
			send_last_high_warning = false
		elseif percentage > LIMITS.first_low then
			send_first_low_warning = true
		elseif percentage > LIMITS.last_low then 
			send_last_low_warning = true
		end
	end

end

hs.battery.watcher.new(check_percentage):start()

local function warn_first_low()
	hs.notify.new(nil, {
		title = 'Kabel anschließen ⚡️',
		subTitle =  'Ladung bei ' .. LIMITS.first_low .. ' %',
		informativeText = 'Strom bitte! 😋',
		soundName = 'Blow',
		withdrawAfter = 25
	}):send()
end

local function warn_last_low()
	hs.notify.new(nil, {
		title = 'Kabel anschließen ⚡️',
		subTitle = 'Ladung bei ' .. LIMITS.last_low .. ' %',
		informativeText = 'Bitte steck mich an! 😣',
		soundName = 'Blow',
		withdrawAfter = 25
	}):send()
end

local function warn_first_high()
	hs.notify.new(nil, {
		title = 'Verbindung trennen ⚡️',
		subTitle = 'Ladung bei ' .. LIMITS.first_high .. ' %',
		informativeText = 'Ich bin so satt, ich mag kein Watt. 🤤',
		soundName = 'Blow',
		withdrawAfter = 25
	}):send()
end

function warn_last_high()
	hs.notify.new(nil, {
		title = 'Verbindung trennen ⚡️',
		subTitle= 'Ladung bei ' .. LIMITS.last_high .. ' %',
		informativeText = 'Danger! Danger! High Voltage! 😱',
		soundName = 'Blow',
		withdrawAfter = 25
	}):send()
end
