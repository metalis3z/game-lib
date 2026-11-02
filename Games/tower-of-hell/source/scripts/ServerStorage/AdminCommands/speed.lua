local module = {}

local timerSpeed = game:GetService("ReplicatedStorage").TimerSpeed
local multiplierVisible = game:GetService("ReplicatedStorage").MultiplierVisible
local multiplies = game:GetService("ReplicatedStorage").Multiplies

module.run = function(player, message, args)
	local multiplier = 2
	if args[1] and tonumber(args[1]) then multiplier = args[1] end

	timerSpeed.Value = timerSpeed.Value / multiplier
	multiplies.Value = multiplier
	multiplierVisible.Value = true
end

return module