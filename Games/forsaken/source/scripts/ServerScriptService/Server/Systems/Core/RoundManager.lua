local module = {
	IntermissionTimePast = 0,
	DoHeartbeat = true,
	Connections = {},
	RoundEnding = false,
	RoundInitiating = false
}

local Actors = require(game.ReplicatedStorage.Modules.Actors)
local StatsModule = require(game.ReplicatedStorage.Modules.Stats)
local Sounds = require(game.ReplicatedStorage.Modules.Sounds)
local Util = require(game.ReplicatedStorage.Modules.Util)
local ServerUtil = require(game.ServerScriptService.Server.Modules.ServerUtil)
local Maps = require(game.ReplicatedStorage.Modules.Maps)
local Network = require(game.ReplicatedStorage.Modules.Network)
local Configuration = require(script.Configuration)
local FPSValue
local GamemodeSelection = require(game.ServerStorage.GlebSakenConfig).GamemodeSelection

local CurrentGamemode = "Standard"
local CurrentMap = {}
local DeathTimes = {}

local safeCall = ServerUtil.SafeCall

function PickGamemode()
	local forced = workspace:GetAttribute("ForcedGamemode")
	if forced and game.ReplicatedStorage.Modules.Gamemodes:FindFirstChild(forced) then
		return forced
	end
	if not GamemodeSelection then return "Standard" end

	local available = {}
	for _, gamemode in ipairs(game.ReplicatedStorage.Modules.Gamemodes:GetChildren()) do
		if gamemode:IsA("ModuleScript") then
			local success, config = safeCall(require, gamemode)
			if success and type(config) == "table" then
				if config.Enabled ~= false and config.Exclusive ~= true and #game.Players:GetPlayers() >= (config.PlayerRequirement or 0) then
					table.insert(available, gamemode.Name)
				end
			end
		end
	end
	if #available == 0 then
		warn("No gamemodes found.")
		return "Standard"
	end
	return available[math.random(1, #available)]
end

function GetEligiblePlayers()
	local currentPlrs = {}
	for _, plr in ipairs(game.Players:GetPlayers()) do
		local plrSettings = plr:FindFirstChild("PlayerData") and plr.PlayerData:FindFirstChild("Settings")
		if plr:GetAttribute("Loaded") and plrSettings and (not plrSettings:FindFirstChild("AFK", true) or not plrSettings:FindFirstChild("AFK", true).Value) then
			table.insert(currentPlrs, {Instance = plr})
		end
	end
	return currentPlrs
end

-- plays a winner cutscene for the winner
module.WinnerCutscene = function(_, winner)
	print("[WINNERCUTSCENE] "..winner)
	return safeCall(function()
		if winner == "Killers" then
			local wonKiller = ServerUtil:GetActorsOfType(winner)[1]
			if wonKiller and wonKiller.Rig and wonKiller.Rig.Parent then
				local killerBG : Model = game.ServerStorage.Assets.Instances.KillerBackgrounds.Victory:FindFirstChild(wonKiller.ActorName) and (wonKiller.SkinFolder and game.ServerStorage.Assets.Instances.KillerBackgrounds.Victory[wonKiller.ActorName]:FindFirstChild(wonKiller.SkinFolder.Name) or game.ServerStorage.Assets.Instances.KillerBackgrounds.Victory[wonKiller.ActorName]:FindFirstChild("Default"))
				if killerBG then
					killerBG = killerBG:Clone()
					killerBG.Parent = workspace.Misc
					killerBG.Name = "KillerCutsceneBackground"
					killerBG:PivotTo(CFrame.new(0, 10000, 0))
					game:GetService("Debris"):AddItem(killerBG, 25)
				end
				Network:FireAllClientConnection("PlayWinnerCutscene", "REMOTE_EVENT", winner, ServerUtil:GetActorsOfType(winner))
				return true
			end
		else
			Network:FireAllClientConnection("PlayWinnerCutscene", "REMOTE_EVENT", winner, ServerUtil:GetActorsOfType(winner))
		end
	end)
end

-- starts a round
module.InitRound = function()
	if module.RoundInitiating then
		return
	else
		module.RoundInitiating = true
	end
	local roundTimer = game.ReplicatedStorage.RoundTimer
	roundTimer.Value = Configuration.TimerTexts.Loading
	module.DoHeartbeat = false

	for _, v in ipairs(module.Connections) do
		v:Disconnect()
	end
	module.Connections, DeathTimes = {}, {}

	CurrentGamemode = PickGamemode()
	workspace:SetAttribute("ForcedGamemode", nil)
	local modeModule = require(game.ReplicatedStorage.Modules.Gamemodes[CurrentGamemode])
	module.CurrentSession = {
		TimePast = 0,
		Time = 240,
		TimeAddedOnKill = 35,
		LastSurvivorAlive = false,
		Gamemode = nil,
		Players = GetEligiblePlayers(),
		StartTime = tick()
	}
	module.CurrentSession.Gamemode = modeModule.Init(module.CurrentSession)
	for i, v in pairs(module.CurrentSession) do
		module.CurrentSession[i] = modeModule[i] or module.CurrentSession[i]
	end
	module.CurrentSession.Loaded = true
	Network:FireAllClientConnection("HandleGamemode", "REMOTE_EVENT", "Init", CurrentGamemode, module.CurrentSession)

	for _, actor in pairs(Actors.CurrentActors) do
		task.spawn(function()
			local rig : Model = actor.Rig
			local plr : Player = actor.Player
			local actorType = actor.ActorType
			if actorType == "Killer" and workspace:GetAttribute("ServerType") ~= "VIP" then
				local killerChance = plr and plr:FindFirstChild("PlayerData") and plr.PlayerData:FindFirstChild("Stats") and plr.PlayerData.Stats:FindFirstChild("KillerChance", true)
				if killerChance and killerChance:IsA("NumberValue") then
					killerChance.Value = 1
				end
			end
			if rig and rig:FindFirstChildOfClass("Humanoid") then
				local deathConnection = rig:FindFirstChildOfClass("Humanoid").Died:Connect(function()
					if plr and actorType == "Survivor" then
						DeathTimes[plr] = tick()-module.CurrentSession.StartTime
					end
					local losses : NumberValue = plr and plr:FindFirstChild("PlayerData") and plr.PlayerData:FindFirstChild(actorType.."Losses", true)
					if losses then
						losses.Value+=1
					end
				end)
				table.insert(module.Connections, deathConnection)
			else
				return
			end
		end)
	end
	task.wait(0.25)

	CurrentMap = Maps:CreateMap("Random")
	module.DoHeartbeat = true
	module.RoundInitiating = false
end

-- ends a round
module.EndRound = function(survivorCount, killerCount)
	if module.RoundEnding then
		return
	else
		module.RoundEnding = true
	end
	module.DoHeartbeat = false

	local winner = (survivorCount > 0 or killerCount < 1) and "Survivors" or "Killers"
	print("[ROUNDMANAGER] "..winner)
	for _, actor in pairs(ServerUtil:GetActorsOfType(winner)) do
		if actor.Player then
			actor.Username = actor.Player.Name
		end
	end

	if workspace.Themes:FindFirstChild("LastSurvivor") then
		workspace.Themes.LastSurvivor:Destroy()
	end
	StatsModule:CreateStatsFolder()
	workspace.Misc:ClearAllChildren()
	if CurrentMap and CurrentMap.Map then
		CurrentMap.Map:Destroy()
	end
	workspace.Map.Ingame:ClearAllChildren()
	Network:FireConnection("RoundEnded", "BINDABLE_EVENT")
	Network:FireAllClientConnection("RoundEnded", "REMOTE_EVENT")
	safeCall(module.CurrentSession.Gamemode.Destroy)
	Network:FireAllClientConnection("HandleGamemode", "REMOTE_EVENT", "Destroy", module.CurrentSession)

	if #GetEligiblePlayers() > 1 or workspace:GetAttribute("Testing") then
		module:WinnerCutscene(winner)
	end

	for _, actor in pairs(Actors.CurrentActors) do
		task.spawn(function()
			if not actor.Player then return end
			if not actor.Player:FindFirstChild("PlayerData") then return end
			if (not actor.Rig) or (not actor.Rig:FindFirstChildOfClass("Humanoid")) or actor.Rig:FindFirstChildOfClass("Humanoid").Health <= 0 then
				return
			end

			local value : NumberValue = actor.Player:FindFirstChild("PlayerData") and actor.Player.PlayerData:FindFirstChild(actor.ActorType.."s"==winner and string.sub(winner, 1, string.len(winner)-1).."Wins" or actor.ActorType.."Losses", true)
			if value then
				value.Value += 1
			end

			local reward
			if actor.ActorType == "Survivor" and winner == "Survivors" then
				reward = Configuration.SurvivorWinReward
			elseif actor.ActorType == "Killer" then
				reward = winner == "Killers" and Configuration.KillerWinReward or Configuration.KillerLostReward
			end
			if not reward then return end

			Actors:IncrementActorStats(actor.Player, reward)
		end)
		local player = actor.Player
		safeCall(function() Actors:CleanupActorFromPlayer(actor.Player) end)
		task.delay(1, function()
			player:LoadCharacter()
		end)
	end
	task.delay(1, function()
		for _, survivor in pairs(workspace.Players.Survivors:GetChildren()) do
			if not game.Players:GetPlayerFromCharacter(survivor) then
				survivor:Destroy()
			end
		end
	end)

	for player, time in pairs(DeathTimes) do
		if player.Parent and time >= 60 then
			Actors:IncrementActorStats(player, Configuration.SixtySecondReward)
		end
	end

	module.CurrentSession = nil
	module.IntermissionTimePast = 0
	ServerUtil:LoadPosters()

	task.wait(1.5)
	module.DoHeartbeat = true
	module.RoundEnding = false

end

-- activates last man standing
module.LMS = function()
	module.CurrentSession.LastSurvivorAlive = true
	module.DoHeartbeat = false
	local Killers = ServerUtil:GetActorsOfType("Killers", true)
	local LastKiller = Killers[1]
	local LastSurvivor = ServerUtil:GetActorsOfType("Survivors", true)[1]
	local LMS = {
		ThemeID = game.ReplicatedStorage.Assets.Sounds.OST.eternalFight.SoundId,
		ThemeProperties = {
			Volume = 1,
		},
		RoundTime = 72,
	}


	if LastKiller and LastSurvivor then
		local specialTheme
		if LastKiller.Config and LastKiller.Config.LastManStandingEmotionalData and LastKiller.Config.Relations then
			
			local Relations = table.clone(LastKiller.Config.Relations)
			local DefaultFolder = LastKiller.Folder
			if typeof(DefaultFolder) == "Instance" and DefaultFolder:IsA("Folder") then
				local defaultConfig = DefaultFolder:FindFirstChild("Config")
				if defaultConfig then
					defaultConfig = require(defaultConfig)
					if defaultConfig.Relations then
						for _, relation in pairs(defaultConfig.Relations) do
							if not table.find(Relations, relation) then
								table.insert(Relations, relation)
							end
						end
					end
				end
			end
			
			local foundLMS = false
			for _, Name in ipairs(Relations) do
				if (LastSurvivor.SkinFolder and LastSurvivor.SkinFolder.Name == Name) or LastSurvivor.ActorName == Name then
					specialTheme = LastKiller.Config.LastManStandingEmotionalData[Name]
					foundLMS = true
					break
				end
			end
			
			if (not specialTheme) and foundLMS then
				specialTheme = LastKiller.Config.LastManStandingEmotionalData
			end
		end

		if not specialTheme then
			specialTheme = (LastKiller.Config and LastKiller.Config.LastManStandingData) or (LastSurvivor.Config and LastSurvivor.Config.LastManStandingData) or nil
		end
		
		LMS = specialTheme or LMS
		LMS.ThemeProperties = LMS.ThemeProperties or {}
		LMS.ThemeProperties.Priority = 10
		
	end

	module.CurrentSession.TimePast = 0
	module.CurrentSession.Time = LMS.RoundTime
	local theme = Sounds:PlayTheme(LMS.ThemeID, LMS.ThemeProperties)
	theme.Name = "LastSurvivor"
	safeCall(function()
		for _, killer in pairs(Killers) do
			Util:RevealPlayerAuraTo(killer.Rig, LastSurvivor.Rig, 8)
			Util:RevealPlayerAuraTo(LastSurvivor.Rig, killer.Rig, 8)
		end
	end)

	if LastKiller.Behavior and LastKiller.Behavior.OnLMS then
		task.spawn(function()
			LastKiller.Behavior:OnLMS(LastSurvivor)
		end)
	end
	if LastSurvivor.Behavior and LastSurvivor.Behavior.OnLMS then
		task.spawn(function()
			LastSurvivor.Behavior:OnLMS(LastKiller)
		end)
	end

	Network:FireAllClientConnection("LastSurvivor", "REMOTE_EVENT")
	module.DoHeartbeat = true
end

module.Start = function()
	FPSValue = workspace:GetAttribute("Testing") and game.ReplicatedStorage:WaitForChild("ServerFPS")
	game["Run Service"].Heartbeat:Connect(function(delta)
		if workspace:GetAttribute("Testing") then
			FPSValue.Value = math.floor(1 / delta)
		end

		if not module.DoHeartbeat then return end

		local RoundTimer = game.ReplicatedStorage.RoundTimer

		if module.CurrentSession and module.CurrentSession.Loaded and CurrentMap and CurrentMap.Map then
			-- DURING ROUND
			if workspace:GetAttribute("NoTimer") then
				RoundTimer:SetAttribute("TimeLeft", 5999)
				RoundTimer.Value = Configuration.TimerTexts.TimerDisabled
				return
			end

			--local Survivors = 0
			--local Killers = 0
			--for _, survivor in pairs(workspace.Players.Survivors:GetChildren()) do
			--	if survivor:IsA("Model") and survivor:FindFirstChildOfClass("Humanoid") and survivor:FindFirstChildOfClass("Humanoid").Health > 0 then
			--		Survivors+=1
			--	end
			--end
			--for _, killer in pairs(workspace.Players.Killers:GetChildren()) do
			--	if killer:IsA("Model") and killer:FindFirstChildOfClass("Humanoid") and killer:FindFirstChildOfClass("Humanoid").Health > 0 then
			--		Killers+=1
			--	end
			--end
			
			local Survivors = ServerUtil:GetActorsOfType("Survivors", true)
			local Killers = ServerUtil:GetActorsOfType("Killers", true)

			if module.CurrentSession.TimePast >= module.CurrentSession.Time or #Survivors <= 0 or #Killers <= 0 then
				task.delay(0.25, module.EndRound, #Survivors, #Killers)
			elseif (not module.CurrentSession.LastSurvivorAlive) and #Survivors == 1 and #Killers > 0 then
				module:LMS()
			end

			if not module.CurrentSession then return end

			RoundTimer.Value = Configuration.TimerTexts.DuringRound
			module.CurrentSession.TimePast += delta
			RoundTimer:SetAttribute("TimeLeft", module.CurrentSession.Time - module.CurrentSession.TimePast)
		else
			-- DURING INTERMISSION
			if module.IntermissionTimePast >= Configuration.LobbyIntermissionTime then
				module.IntermissionTimePast = 0
				module.InitRound()
				return
			end

			if workspace:GetAttribute("NoTimer") then return end

			if #GetEligiblePlayers() <= 1 then
				module.IntermissionTimePast = 0
				RoundTimer.Value = Configuration.TimerTexts.InsufficientPlayers
				RoundTimer:SetAttribute("TimeLeft", 0)
				return
			end

			RoundTimer.Value = Configuration.TimerTexts.Lobby
			module.IntermissionTimePast += delta
			RoundTimer:SetAttribute("TimeLeft", Configuration.LobbyIntermissionTime - module.IntermissionTimePast)
		end
	end)
end

-- adds timeAmount to the round timer
module.AddTime = function(_, timeAmount : number, timeMultiplier : number)
	if not module.CurrentSession then
		return
	end
	if not module.CurrentSession.TimePast then
		return
	end
	local timeAdded = timeAmount or (module.CurrentSession.Gamemode and module.CurrentSession.Gamemode.TimeAddedOnKill) or 35
	timeAdded *= timeMultiplier or 1
	module.CurrentSession.TimePast -= timeAdded
end

task.delay(5, function()
	ServerUtil:LoadPosters()
end)

return module