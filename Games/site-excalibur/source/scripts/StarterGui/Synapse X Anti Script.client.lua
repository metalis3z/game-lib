local plr = game.Players.LocalPlayer
local Statss = game:GetService("Stats")
local RunService = game:GetService("RunService")
local maxrate = 30
wait(5)

local previousCMU = 0
RunService.Heartbeat:Connect(function()
	local CMU = Statss:GetTotalMemoryUsageMb()
	if (CMU - previousCMU) > maxrate and previousCMU ~= 0 then
		while true do end
	end
	previousCMU = CMU
end)