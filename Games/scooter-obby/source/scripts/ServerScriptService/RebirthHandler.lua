local ds2 = require(game.ReplicatedStorage.ModuleScripts.DataStore2)
ds2.Combine("DATA", "rebirth")
local rs = game:GetService("ReplicatedStorage")
local marketplaceService = game:GetService("MarketplaceService")

game.Players.PlayerAdded:Connect(function(player)
	--[[local rebirthStore = ds2("rebirth", player)
	local rebirths = rebirthStore:Get(0)
	player:WaitForChild("leaderstats")
	local rebirthstat = Instance.new("NumberValue", player.leaderstats)
	rebirthstat.Name = "Rebirth"
	rebirthstat.Value = rebirths
	local function callRemote(value)
		rebirthstat.Value = value
	end
	
	rebirthStore:OnUpdate(callRemote)]]--
end)

local module = {}

function module.Reset(player)
	player.leaderstats.Stage.Value = 0
	local stageObjects = {}

	local CollectionService = game:GetService("CollectionService")

	for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
		local stage = cp:GetAttribute("Stage")

		if not stageObjects[stage] then
			stageObjects[stage] = {}
		end

		table.insert(stageObjects[stage], cp)
	end
	rs.RemoteEvents.clientTP:FireClient(player, stageObjects[game.Players:FindFirstChild(player.Name).leaderstats.Stage.Value])
	return 
end

return module
