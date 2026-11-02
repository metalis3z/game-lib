--// REAL CUSTOM COUNTDOWN LOCAL SCRIPT

local Countdown = script.Parent

--------------------------------------------------
-- 🔹 CHANGE THIS TO YOUR DATE / TIME
--------------------------------------------------
local targetTime = os.time({
	year = 2026,
	month = 3,
	day = 7,
	hour = 20,   -- 6 PM
	min = 0,
	sec = 0
})

--------------------------------------------------
-- 🔹 COUNTDOWN LOOP
--------------------------------------------------
while true do
	local now = os.time()
	local timeLeft = targetTime - now

	-- When countdown ends
	if timeLeft <= 0 then
		Countdown.Text = "🚀 Update is LIVE!"
		break
	end

	-- Convert seconds
	local days = math.floor(timeLeft / 86400)
	local hours = math.floor((timeLeft % 86400) / 3600)
	local minutes = math.floor((timeLeft % 3600) / 60)
	local seconds = timeLeft % 60

	-- Update text
	Countdown.Text = string.format(
		"Gone in %dd %02dh %02dm %02ds",
		days, hours, minutes, seconds
	)

	task.wait(1)
end