local label = script.Parent

local function getNextHourTime()
	local now = os.time()
	local nextHour = now - (now % 3600) + 3600
	return nextHour
end

while true do
	local now = os.time()
	local target = getNextHourTime()
	local remaining = target - now

	if remaining < 0 then
		remaining = 0
	end

	local minutes = math.floor(remaining / 60)
	local seconds = remaining % 60

	if minutes > 0 then
		label.Text = string.format("%dm %02ds", minutes, seconds)
	else
		label.Text = string.format("%ds", seconds)
	end

	task.wait(0.01)
end
