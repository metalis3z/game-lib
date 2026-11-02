local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)

-- Calculate time until January 10, 2026 (US format: MM/DD/YYYY)
local targetDate = os.time({
	year = 2026,
	month = 1,    -- January
	day = 10,     -- 10th
	hour = 20,
	min = 0,
	sec = 0
})

while true do
	local currentTime = os.time()
	local timeLeft = targetDate - currentTime

	if timeLeft > 0 then
		-- Use TimeUtils:E() with the fixed format strings
		script.Parent.Text = "Releases in " .. TimeUtils:E(timeLeft)
	else
		script.Parent.Text = "Update Live!"
	end

	task.wait(1)
end