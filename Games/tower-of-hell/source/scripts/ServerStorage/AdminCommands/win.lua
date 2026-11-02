local module = {}

local modules = game:GetService("ServerStorage").AdminModules

local playersService = game:GetService("Players")

local towerHeight = game:GetService("ReplicatedStorage").TowerHeight
local winBrick = workspace.Storage.End.WinBrick

function lowerPlayer(str)
	for _,plr in pairs(playersService:GetPlayers()) do
		if plr.Name:lower() == str then return {plr} end
	end
end

module.run = function(player, message, args)
	local target
	if args[1] then target = require(modules.FetchTarget)(args[1]:lower(), player)
	else target = {player}
	end
	if not target or not target[1] then return end
	
	for _,plr in pairs(target) do
		if not plr.Character then continue end
		if not plr.Character:FindFirstChild("Humanoid") then continue end
		if plr.Character.Humanoid.Health == 0 then continue end

		plr.Character:SetPrimaryPartCFrame((winBrick.CFrame)* CFrame.new(0, -2, -20))
	end
end

return module