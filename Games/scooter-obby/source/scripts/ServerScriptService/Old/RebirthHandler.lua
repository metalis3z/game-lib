local ds2 = require(game.ReplicatedStorage.ModuleScripts.DataStore2)
ds2.Combine("DATA", "rebirth")
local rs = game:GetService("ReplicatedStorage")
local marketplaceService = game:GetService("MarketplaceService")

game.Players.PlayerAdded:Connect(function(player)
	local rebirthStore = ds2("rebirth", player)
	local rebirths = rebirthStore:Get(0)
	player:WaitForChild("leaderstats")
	local rebirthstat = Instance.new("NumberValue", player.leaderstats)
	rebirthstat.Name = "Rebirth"
	rebirthstat.Value = rebirths
	local function callRemote(value)
		rebirthstat.Value = value
	end
	
	rebirthStore:OnUpdate(callRemote)
end)

local module = {}

function module.Rebirth(player)
	local rebirthStore = ds2("rebirth", player)
	local rebirths = rebirthStore:Get(0)
	
	if player.leaderstats.Stage.Value >= 100 then
		player.leaderstats.Stage.Value = 1
		player.hidden.HighestStage.Value = 1
		rs.RemoteEvents.clientTP:FireClient(player)
		if marketplaceService:UserOwnsGamePassAsync(player.UserId, 662979491) then
			rebirthStore:Increment(2)
		else
			rebirthStore:Increment(1)
		end
	end
	return 
end

function module.Reset(player)
		player.leaderstats.Stage.Value = 1
		rs.RemoteEvents.clientTP:FireClient(player)
	return 
end

return module
