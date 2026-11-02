local module = {}

local Network = require(game.ReplicatedStorage.Modules.Network)
local Actors = require(game.ReplicatedStorage.Modules.Actors)
local ChatCommands = require(script.ChatCommands)
local GlobalConfig = require(game.ServerStorage.GlebSakenConfig)
local ManualRanks = GlobalConfig.ManualRanks
local CustomTitles = GlobalConfig.CustomTitles
local Data = require(game.ServerScriptService.Server.Systems.Data.PlayerData)
local Leaderstats = require(game.ServerScriptService.Server.Systems.Data.LeaderStats)
local ProductHandler = require(game.ServerScriptService.Server.Systems.Shopping.ProductHandler)
local AchievementHandler = require(game.ServerScriptService.Server.Systems.Misc.AchievementHandler)
local AchievementUtil = require(game.ReplicatedStorage.Modules.AchievementUtil)

local CharacterMultipliers = {
	"FOV",
	"Resistance",
	"SpeedCap",
	"Speed"
}

module.Start = function()
	task.spawn(function()
		for _, plr in pairs(game.Players:GetPlayers()) do
			module.InitPlayer(plr)
		end
		game.Players.PlayerAdded:Connect(module.InitPlayer)
		game.Players.PlayerRemoving:Connect(module.RemovePlayer)
	end)

end

module.InitCharacter = function(_, Character : Model, Player : Player)
	if Character.Parent == game.Workspace then
		Character.Parent = workspace.Players.Spectating
		Character.PrimaryPart = Character.HumanoidRootPart
		for _, part in pairs(Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CollisionGroup = "Players"
			end
		end
		Character.Humanoid:SetAttribute("BaseSpeed", 16)
	else
		Character.Archivable = true
	end

	for _, multiplier in pairs(CharacterMultipliers) do
		if not Character:FindFirstChild(multiplier.."Multipliers") then
			Instance.new("Folder", Character).Name = multiplier.."Multipliers"
		end
	end

	Character.Humanoid.Died:Connect(function()
		Network:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", Character)
	end)

	local voidkillConnection
	voidkillConnection = Character.PrimaryPart.AncestryChanged:Connect(function()
		voidkillConnection:Disconnect()
		task.wait(game.Players.RespawnTime+1)
		if Character.Parent then
			Player:LoadCharacter()
		end
	end)
end

module.InitPlayer = function(Player : Player)
	local Rank = (game["Run Service"]:IsStudio() and Player.UserId < 0) and 999 or (game.CreatorType == Enum.CreatorType.Group and Player:GetRankInGroup(game.CreatorId) or ManualRanks[Player.UserId] or 0)
	if not game["Run Service"]:IsStudio() and (not GlobalConfig.FreeTesting) and (Rank or 0)<10 then
		Player:SetAttribute("NotAllowed", true)
		Player:Kick(GlobalConfig.NotAllowedKickMsg)
	end
	Player:SetAttribute("Rank", Rank)
	Data:LoadData(Player)
	Leaderstats:AddStats(Player)
	ProductHandler:ActivatePasses(Player)
	if GlobalConfig.FreeVIP then
		Player:SetAttribute("VIP", true)
	end

	if Player.Character then
		module:InitCharacter(Player.Character, Player)
	end

	Player.CharacterAdded:Connect(function(Character)
		module:InitCharacter(Character, Player)
	end)

	if game["Run Service"]:IsStudio() or (Player:GetAttribute("Rank") or 0)>=100 then
		Player.Chatted:Connect(function(msg)
			local args = string.split(msg, " ")
			local cmdName = args[1]
			if type(ChatCommands[cmdName]) == "function" then
				table.remove(args, 1)
				ChatCommands[cmdName](Player, table.unpack(args))
			end
		end)
	end
	if Rank and Rank >= 2 then
		local closestRank = 0
		local closestRankName = CustomTitles[Player.UserId] or game.CreatorType == Enum.CreatorType.Group and GlobalConfig.PreferCustomRankNames == false and Player:GetRoleInGroup(game.CreatorId)
		if not closestRankName then
			for name, number in pairs(require(game.ServerScriptService.Server.Modules.RankNames)) do
				if number <= Rank and math.abs(number-Rank) < math.abs(closestRank-Rank) then
					closestRank = number
					closestRankName = name
				end
			end
		end
		Player:SetAttribute("RankTitle", closestRankName)
	end
	task.spawn(function()
		while Player.Parent and Player:FindFirstChild("PlayerData") do
			Player.PlayerData.Stats.General.TimePlayed.Value += 1
			task.wait(1)
		end
	end)
	AchievementHandler:StartEXPConnections(Player)
end

module.RemovePlayer = function(Player)
	task.spawn(function()
		Data:SaveData(Player)
	end)
	AchievementHandler:SeverConnections(Player)
	local currentSession = require(game.ServerScriptService.Server.Systems.Core.RoundManager).CurrentSession
	if currentSession then
		local actor = Actors.CurrentActors[Player]
		local actorType = "Survivor"
		if actor then
			actorType = actor.ActorType
			local rig = actor.Rig
			local attackerName = rig:GetAttribute("RecentAttacker")
			if attackerName and rig:GetAttribute("RecentAttackerTime") and (tick()-rig:GetAttribute("RecentAttackerTime") <= 10) then
				local attacker = game.Players:FindFirstChild(attackerName)
				if attacker then
					Actors:IncrementActorStats(attacker, {
						Action = "Survivor ragequit mid-chase",
						Money = 15,
						EXP = 45
					})
					currentSession.TimePast -= currentSession.Gamemode.TimeAddedOnKill or 35
					AchievementUtil:IncrementAchievementProgress(attacker, "MakePlayerRagequit")
				end
			end
			if Player:FindFirstChild("PlayerData") and Player.PlayerData:FindFirstChild(actorType.."Losses") then
				Player.PlayerData:FindFirstChild(actorType.."Losses").Value +=1
			end
		end
	end
end

return module