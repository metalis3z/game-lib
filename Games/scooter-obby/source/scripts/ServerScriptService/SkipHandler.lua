local ds2 = require(game.ReplicatedStorage.ModuleScripts.DataStore2)
ds2.Combine("DATA", "skips")
local rs = game:GetService("ReplicatedStorage")

local module = {}

function module.GetSkips(player)
	local skipStore = ds2("skips", player)
	local skips = skipStore:Get(0)
	player.PlayerGui.GameGUI.Frame.Stat.SkipsStat.Top.Label.Text = skips
	return skips
end

function module.AddSkips(player, amount)
	local skipStore = ds2("skips", player)
	local skips = skipStore:Get(0)
	skipStore:Increment(amount)
	player.PlayerGui.GameGUI.Frame.Stat.SkipsStat.Top.Label.Text = skips
	return skips
end

function module.SkipStage(player)
	if not rs.Loaded.Value then
		return
	end
	local skipStore = ds2("skips", player)
	local skips = skipStore:Get(0)
	if player.Character and player.Character:FindFirstChild("Humanoid") and skips >= 1 then
		if player.leaderstats.Stage.Value < 20 then
			player.leaderstats.Stage.Value += 1
		end
		local stageObjects = {}

		local CollectionService = game:GetService("CollectionService")

		for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
			local stage = cp:GetAttribute("Stage")

			if not stageObjects[stage] then
				stageObjects[stage] = {}
			end

			table.insert(stageObjects[stage], cp)
		end
		game.Players:FindFirstChild(player.Name):SetAttribute("Safe2", .5)
		rs.RemoteEvents.clientTP:FireClient(player, stageObjects[game.Players:FindFirstChild(player.Name).leaderstats.Stage.Value])
		player:SetAttribute("Safe", true)
		skipStore:Increment(-1)
		player.PlayerGui.GameGUI.Frame.Stat.SkipsStat.Top.Label.Text = skips
	end
	return 
end

return module
