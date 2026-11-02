local ds2 = require(game.ReplicatedStorage.ModuleScripts.DataStore2)
ds2.Combine("DATA", "skips")
local rs = game:GetService("ReplicatedStorage")

local module = {}

function module.GetSkips(player)
	local skipStore = ds2("skips", player)
	local skips = skipStore:Get(0)
	return skips
end

function module.AddSkips(player, amount)
	local skipStore = ds2("skips", player)
	local skips = skipStore:Get(0)
	skipStore:Increment(amount)
	rs.RemoteEvents.skipNotification:FireClient(player, amount)
	return skips
end

function module.SkipStage(player)
	local skipStore = ds2("skips", player)
	local skips = skipStore:Get(0)
	if player.Character and player.Character:FindFirstChild("Humanoid") and skips >= 1 then
		if player.leaderstats.Stage.Value < 100 then
			player.leaderstats.Stage.Value += 1
		end
		rs.RemoteEvents.clientTP:FireClient(player)
		skipStore:Increment(-1)
	end
	return 
end

return module
