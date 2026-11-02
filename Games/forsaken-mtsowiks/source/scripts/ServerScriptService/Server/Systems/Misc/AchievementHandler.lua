local module = {
	Connections = {}
}

local Util = require(game.ReplicatedStorage.Modules.Util)
local AchievementUtil = require(game.ReplicatedStorage.Modules.AchievementUtil) 
local ServerUtil = require(game.ServerScriptService.Server.Modules.ServerUtil)
local safecall = ServerUtil.SafeCall

function module:StartEXPConnections(Player : Player)
	local plrData = Player:WaitForChild("PlayerData", 30)
	if not plrData then return end
	local purchased = plrData:FindFirstChild("Purchased")
	if not purchased then return end
	module.Connections[Player] = {}
	
	local function StartValueConnection(val : IntValue)
		if (not val:IsA("IntValue")) then return end
		local skinsFolder = game.ReplicatedStorage.Assets.Skins[val.Parent.Name]:FindFirstChild(val.Name)
		table.insert(module.Connections[Player], val:GetPropertyChangedSignal("Value"):Connect(function()
			local level = Util:CalculateLevelFromEXP(val.Value)
			ServerUtil:SetAchievementProgress(Player, val.Name.."Milestone", math.clamp(level, 0, 100))
			if skinsFolder then
				local availableLevels = {}
				for _, v in pairs({25, 50, 75, 100}) do
					if v <= level then
						table.insert(availableLevels, v)
					end
				end
				for _, skin in pairs(skinsFolder:GetChildren()) do
					if purchased.Skins:FindFirstChild(skin.Name) then continue end
					if not (string.sub(skin.Name,1,9)=="Milestone") then continue end
					for _, Level in pairs(availableLevels) do
						local msName = "Milestone"..Level
						if string.sub(skin.Name, 1, string.len(msName)) == msName then
							task.spawn(function()
								Instance.new("IntValue", purchased.Skins).Name = skin.Name
							end)
						end
					end
				end
			end
		end))
	end
	
	for _, actorType in pairs(purchased:GetChildren()) do
		if actorType.Name ~= "Killers" and actorType.Name ~= "Survivors" then continue end
		for _, actor in pairs(actorType:GetChildren()) do
			StartValueConnection(actor)
		end
		table.insert(module.Connections[Player], actorType.ChildAdded:Connect(StartValueConnection))
	end
end

function module:SeverConnections(Player : Player)
	task.spawn(function()
		local connections = module.Connections[Player]
		if not connections then return end
		for _, connection : RBXScriptConnection in pairs(connections) do
			connection:Disconnect()
		end
	end)
end

return module