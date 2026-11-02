local module = {}

local modules = game:GetService("ServerStorage").AdminModules

local playersService = game:GetService("Players")

local towerHeight = game:GetService("ReplicatedStorage").TowerHeight
local tower = workspace.Tower

function lowerPlayer(str)
	for _,plr in pairs(playersService:GetPlayers()) do
		if plr.Name:lower() == str then return {plr} end
	end
end

module.run = function(player, message, args)
	if not args[1] then return end
	if not tonumber(args[1]) then return end
	
	local chosenSection = tower:GetChildren()[tonumber(args[1])]
	if not chosenSection then return end
	if not chosenSection:FindFirstChild("StartPlatform") then return end
	
	local target
	if args[2] then target = require(modules.FetchTarget)(args[2]:lower(), player)
	else target = {player}
	end
	if not target or not target[1] then return end
	
	for _,plr in pairs(target) do
		if not plr.Character then continue end
		if not plr.Character:FindFirstChild("Humanoid") then continue end
		if plr.Character.Humanoid.Health == 0 then continue end

		plr.Character:SetPrimaryPartCFrame((chosenSection.StartPlatform.CFrame)* CFrame.new(0, 8, 0))
	end
end

return module