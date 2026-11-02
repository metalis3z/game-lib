local module = {}
local Actors = require(game.ReplicatedStorage.Modules.Actors)
local Art = require(game.ServerStorage.Assets.Miscellaneous.Art)
local Network = require(game.ReplicatedStorage.Modules.Network)

module.SafeCall = function(funct, ...)
	local functType = typeof(funct)
	
	if functType ~= "function" then
		warn(`[SAFECALL] attempted to call {functType}`)
	else
		local success, result = pcall(funct, ...)
		if not success then
			local traceback = debug.traceback("", 2)
			warn(`[SAFECALL] {tostring(result)}\nTraceback:\n{traceback}`)
		end
		return success, result
	end
end

module.GetActorsOfType = function(_, ActorType : string, aliveOnly : boolean)
	local actors = Actors.CurrentActors
	local result = {}

	for _, actor in pairs(actors) do
		if actor.ActorType.."s" == ActorType and ((actor.Rig and actor.Rig:FindFirstChildOfClass("Humanoid") and actor.Rig:FindFirstChildOfClass("Humanoid").Health > 0) or not aliveOnly) then
			table.insert(result, actor)
		end
	end
	return result
end

module.LoadPosters = function()
	if not workspace:GetAttribute("Testing") then
		local availableArt = {}
		for i, v in ipairs(Art) do
			table.insert(availableArt, v)
		end
		for i, v in ipairs(workspace.Map.Lobby.Posters:GetChildren()) do
			if #availableArt > 0 then
				local selectedNumber = math.random(1, #availableArt)
				local selectedArt = availableArt[selectedNumber]
				v.PosterUI.Poster.Image = selectedArt.Image
				v.PosterUI.Credit.Text = selectedArt.Credit
				table.remove(availableArt, selectedNumber)
			else
				for i, v in ipairs(Art) do
					table.insert(availableArt, v)
				end
			end
		end
	end
end

function module:SetAchievementProgress(Player : Player, Achievement : string, Progress : number)
	local success, result = module.SafeCall(function()
		local plrData = Player:FindFirstChild("PlayerData")
		if not plrData then return end
		local AchievementFolder = plrData:FindFirstChild("Achievements")
		if not AchievementFolder then return end
		local AchievementVal : IntValue = AchievementFolder:FindFirstChild(Achievement, true)
		if (not AchievementVal) or (not AchievementVal:IsA("IntValue")) then return end
		AchievementVal.Value = Progress
	end)
	return success and result
end

return module