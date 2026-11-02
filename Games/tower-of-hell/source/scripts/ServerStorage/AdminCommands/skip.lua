local module = {}

local replicatedStorage = game:GetService("ReplicatedStorage")

local minutes = replicatedStorage.Minutes
local seconds = replicatedStorage.Seconds
local timerSpeed = replicatedStorage.TimerSpeed

module.run = function(player, message, args)
	timerSpeed.Value = 0.0001
	minutes.Value = 0
	seconds.Value = 0
end

return module