local SETTINGS = {----Scripted by @menos1234567890
	FinalWaveMusicId = "rbxassetid://1845205138",

	CountdownMusicIds = {
		Default = "rbxassetid://114017831521158",
		January = "rbxassetid://114017831521158",
		February = "rbxassetid://114017831521158",
		March = "rbxassetid://1842150151",
		April = "rbxassetid://1842252676",
		May = "rbxassetid://72734512335337",
		June = "rbxassetid://1839744286",
		July = "rbxassetid://1839744286",
		August = "rbxassetid://1839744286",
		September = "rbxassetid://9045971220",
		October = "rbxassetid://118060517973255",
		November = "rbxassetid://87753640000210",
		December = "rbxassetid://1842625342",
	},
	CountdownTime = 45,
	MapLoadingTime = 10,
	DefaultMaxWave = 5,
	PlayerHealth = 100,
	ZombieMultiplier = 1,
	BadgeEnabled = true,
	BadgeId = 3280131123172342,
	ZombiesPerWaveBase = 10,
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local BadgeService = game:GetService("BadgeService")
local CollectionService = game:GetService("CollectionService")
local ZombieManager = require(ReplicatedStorage.Modules.ZombieManager)


-- Utility function to safely clone and parent
local function safeCloneAndParent(source, parent, newName)
	if source then
		local clone = source:Clone()
		if newName then
			clone.Name = newName
		end
		clone.Parent = parent
		return clone
	end
	return nil
end



local function getOrCreateTeam(name, color)
	local t = Teams:FindFirstChild(name)
	if not t then
		t = Instance.new("Team")
		t.Name = name
		t.TeamColor = BrickColor.new(color or "White")
		t.AutoAssignable = false
		t.Parent = Teams
	end
	return t
end
local AliveTeam = getOrCreateTeam("Alive", "Bright green")
local LobbyTeam = getOrCreateTeam("Lobby", "Bright blue")

local function assignTeam(player, team)
	if player and team and player.Team ~= team then player.Team = team end
end

local Values = ReplicatedStorage:WaitForChild("Values")
local roundMsg = Values:WaitForChild("roundMsg")
local zombiesAlive = Values:WaitForChild("zombiesAlive")
local gameInProgress = Values:WaitForChild("gameInProgress")
local wave = Values:WaitForChild("Wave")
local zombieCount = Values:WaitForChild("zombiesRemaining")
local mapsFolder = ReplicatedStorage:WaitForChild("Maps")
local mapContainer = Workspace:WaitForChild("Map")

local function getOrCreateRemote(name)
	local r = ReplicatedStorage.Remotes:FindFirstChild(name)
	if not r then r = Instance.new("RemoteEvent") r.Name = name r.Parent = ReplicatedStorage.Remotes end
	return r
end
local RoundWinners = getOrCreateRemote("RoundWinners")
local SetMaxWave = getOrCreateRemote("SetMaxWave")
local SetCustomMaxWave = getOrCreateRemote("SetCustomMaxWave")
local WaveInfo = getOrCreateRemote("WaveInfo")
local AddExp = ReplicatedStorage.Remotes:FindFirstChild("AddExp")
local RoundTimerUpdate = getOrCreateRemote("RoundTimerUpdate")
local RoundMVP = getOrCreateRemote("RoundMVP")
local RoundStatsSummary = getOrCreateRemote("RoundStatsSummary")
local FinalWaveMusic = getOrCreateRemote("FinalWaveMusic")
local MapVoteHandler = require(ReplicatedStorage.Modules:WaitForChild("MapVoteHandler"))

local function getMonthName()
	return os.date("%B")
end

local function getCountdownMusicId()
	local month = getMonthName()
	return SETTINGS.CountdownMusicIds[month] or SETTINGS.CountdownMusicIds.Default
end

local roundStats = { startTime = 0, endTime = 0, totalZombiesKilled = 0, playerStats = {}, fastestRound = {} }
local function resetStats() roundStats.startTime, roundStats.endTime, roundStats.totalZombiesKilled, roundStats.playerStats = 0,0,0,{} end
local function playerKill(p)
	if not p then return end
	local uid = p.UserId
	local s = roundStats.playerStats
	if not s[uid] then s[uid] = {Kills=0, Deaths=0, Survived=false} end
	s[uid].Kills += 1; roundStats.totalZombiesKilled += 1
end
local function playerDeath(p)
	if not p then return end
	local uid = p.UserId
	local s = roundStats.playerStats
	if not s[uid] then s[uid] = {Kills=0, Deaths=0, Survived=false} end
	s[uid].Deaths += 1
end
local function playerSurvived(p)
	if not p then return end
	local uid = p.UserId
	local s = roundStats.playerStats
	if not s[uid] then s[uid] = {Kills=0, Deaths=0, Survived=false} end
	s[uid].Survived = true
end

local function getTopKillers()
	local mk, top = -1, {}
	for uid, s in roundStats.playerStats do
		if s.Kills > mk then mk = s.Kills; top = {uid}
		elseif s.Kills == mk then table.insert(top, uid)
		end
	end
	return top, mk
end

local function getPlayerWinStreak(p)
	local ls = p:FindFirstChild("leaderstats")
	if ls then local w = ls:FindFirstChild("Wins") if w then return w.Value end end
	return 0
end

-- Helper: Calculate zombies per wave robustly
local function getZombiesForWave(waveNum, multiplier)
	return math.max(1, SETTINGS.ZombiesPerWaveBase * waveNum * (multiplier or SETTINGS.ZombieMultiplier))
end

-- Zombie spawning configuration
local ZOMBIES_PER_SPAWN = 2
local SPAWN_INTERVAL = 4

-- Helper: Get the current map's Zombies folder
local function getZombiesFolder()
	local mapFolder = Workspace:FindFirstChild("Map")
	if not mapFolder then return Workspace end

	-- Find the first model in the Map folder (current active map)
	local mapModel = nil
	for _, child in mapFolder:GetChildren() do
		if child:IsA("Model") then
			mapModel = child
			break
		end
	end

	if not mapModel then return Workspace end

	local zombiesFolder = mapModel:FindFirstChild("Zombies")
	if not zombiesFolder then
		zombiesFolder = Instance.new("Folder")
		zombiesFolder.Name = "Zombies"
		zombiesFolder.Parent = mapModel
	end
	return zombiesFolder
end

-- Helper: Spawn a single zombie at a spawner
local function spawnZombieAt(spawner)
	if not spawner or not spawner:IsA("BasePart") then return end

	local zombieTemplate = ReplicatedStorage:FindFirstChild("Zombie")
	if not zombieTemplate then
		warn("Zombie template not found in ReplicatedStorage")
		return
	end

	local zombiesRemaining = ReplicatedStorage.Values:FindFirstChild("zombiesRemaining")
	if not zombiesRemaining or zombiesRemaining.Value <= 0 then
		return
	end

	local zombie = zombieTemplate:Clone()
	zombie.Name = "Zombie"

	local zombiesFolder = getZombiesFolder()
	zombie.Parent = zombiesFolder

	local humanoidRootPart = zombie:FindFirstChild("HumanoidRootPart")
	if humanoidRootPart then
		zombie:PivotTo(spawner.CFrame)
	else
		warn("Zombie template missing HumanoidRootPart")
	end

	CollectionService:AddTag(zombie, "Zombie")

	zombiesRemaining.Value = zombiesRemaining.Value - 1
	ZombieManager:RegisterZombie(zombie)

	zombie.AncestryChanged:Connect(function(child, parent)
		if not parent then
			ZombieManager:UnregisterZombie(zombie)
		end
	end)
end

-- Main spawn loop
local spawnLoopRunning = false
local function startSpawnLoop()
	if spawnLoopRunning then return end
	spawnLoopRunning = true
	
	task.spawn(function()
		while spawnLoopRunning do
			task.wait(SPAWN_INTERVAL)

			local gameInProgress = ReplicatedStorage.Values:FindFirstChild("gameInProgress")
			local zombiesRemaining = ReplicatedStorage.Values:FindFirstChild("zombiesRemaining")

			if not gameInProgress or not zombiesRemaining then
				continue
			end

			if gameInProgress.Value == true and zombiesRemaining.Value > 0 then
				local spawners = CollectionService:GetTagged("Spawner")

				for _, spawner in spawners do
					if zombiesRemaining.Value <= 0 then
						break
					end

					for j = 1, ZOMBIES_PER_SPAWN do
						if zombiesRemaining.Value <= 0 then
							break
						end
						spawnZombieAt(spawner)
					end
				end
			end
		end
	end)
end

local function stopSpawnLoop()
	spawnLoopRunning = false
end

-- === ROUND LOOP ===
while true do
	-- Clear zombies robustly at start of round
	pcall(function()
		ZombieManager:ClearZombies()
	end)
	stopSpawnLoop()
	for _, p in Players:GetPlayers() do
		p:SetAttribute("IsPlayerZombie", false)
		if p.Character then CollectionService:RemoveTag(p.Character, "PlayerZombie") end
		assignTeam(p, LobbyTeam)
	end

	roundMsg.Value = "ZS modded by happyrang6!"
	task.wait(3)
	roundMsg.Value = "Get Ready! New round is about to begin..."
	task.wait(2)

	local countdownSound = Instance.new("Sound")
	countdownSound.Name = "CountdownMusic"
	countdownSound.SoundId = getCountdownMusicId()
	countdownSound.Volume = 1
	countdownSound.Looped = true
	countdownSound.Parent = Workspace
	countdownSound:Play()

	for i=SETTINGS.CountdownTime,0,-1 do
		roundMsg.Value = "Game Starting in: "..i
		RoundTimerUpdate:FireAllClients({TimeLeft=i,Total=SETTINGS.CountdownTime})
		task.wait(1)
	end

	roundMsg.Value = "Vote for the next map!"
	task.wait(1)
	local winningMap = MapVoteHandler.StartVoting()
	local winnerName = winningMap and winningMap.Name or "Unknown"

	if winningMap then
		local mapValues = winningMap:FindFirstChild("MapValues")
		local mapInfo = {
			Name = winningMap.Name,
			Creator = mapValues and mapValues:FindFirstChild("Creator") and mapValues.Creator.Value or "???",
			Description = mapValues and mapValues:FindFirstChild("Description") and mapValues.Description.Value or "No description.",
			Image = mapValues and mapValues:FindFirstChild("Thumbnail") and mapValues.Thumbnail.Value or "",
		}
		roundMsg.Value = "Selected Map: "..mapInfo.Name.." by "..mapInfo.Creator.."\n"..mapInfo.Description
		task.wait(3)
	else
		roundMsg.Value = "No map selected! Picking random map..."
		task.wait(2)
	end

	countdownSound:Stop()
	countdownSound:Destroy()

	roundMsg.Value = "Loading the map!"
	task.wait(2)
	local chosenMap = nil
	for i=SETTINGS.MapLoadingTime,1,-1 do
		if i == SETTINGS.MapLoadingTime and winningMap then
			chosenMap = winningMap:Clone()
			chosenMap.Parent = mapContainer

		end
		roundMsg.Value = "Loading the map! ("..i.."...)" 
		RoundTimerUpdate:FireAllClients({TimeLeft=i,Total=SETTINGS.MapLoadingTime})
		task.wait(1)
	end
	roundMsg.Value = "Teleporting now..."

	if chosenMap then
		-- Get wave limit from the chosen map
		local function getWaveLimit(map)
			-- Check MapValues folder first
			local mapValues = map:FindFirstChild("MapValues")
			if mapValues then
				local mw = mapValues:FindFirstChild("MaxWave")
				local wl = mapValues:FindFirstChild("WaveLimit")
				if mw and mw:IsA("IntValue") then return mw.Value end
				if wl then
					if wl:IsA("IntValue") then return wl.Value
					elseif wl:IsA("StringValue") then local n = tonumber(wl.Value) if n and n > 0 then return n end end
				end
			end
			-- Check direct children as fallback
			local mw = map:FindFirstChild("MaxWave")
			local wl = map:FindFirstChild("WaveLimit")
			if mw and mw:IsA("IntValue") then return mw.Value end
			if wl then
				if wl:IsA("IntValue") then return wl.Value
				elseif wl:IsA("StringValue") then local n = tonumber(wl.Value) if n and n > 0 then return n end end
			end
			return SETTINGS.DefaultMaxWave
		end
		local maxWave = getWaveLimit(chosenMap)
		SetMaxWave:FireAllClients(maxWave)
		local mapModel = mapContainer:FindFirstChildOfClass("Model")
		local mapMusicSound = nil
		if mapModel then
			local musicFolder = mapModel:FindFirstChild("Music")
			if musicFolder and musicFolder:IsA("Folder") then mapMusicSound = musicFolder:FindFirstChildWhichIsA("Sound") end
		end
		if mapModel then
			for _, c in mapModel:GetChildren() do if c.Name == "Spawner" then CollectionService:AddTag(c, "Spawner") end end
			local spawnLoc = mapModel:FindFirstChild("Spawn")
			if spawnLoc and spawnLoc:IsA("BasePart") then
				for _, p in Players:GetPlayers() do
					local char = p.Character
					if char then
						local hrp = char:FindFirstChild("HumanoidRootPart")
						if hrp then hrp.CFrame = spawnLoc.CFrame end
						CollectionService:AddTag(char, "Alive")
						local h = char:FindFirstChildOfClass("Humanoid")
						if h then h.MaxHealth = SETTINGS.PlayerHealth; h.Health = SETTINGS.PlayerHealth; h.WalkSpeed = 16 end
						CollectionService:RemoveTag(char, "PlayerZombie")
						p:SetAttribute("IsPlayerZombie", false)
						p:SetAttribute("IsJuggernaut", false)
						assignTeam(p, AliveTeam)
					end
				end
			end

			local deathConns = {}
			resetStats()
			roundStats.startTime = os.clock()
			roundStats.mapName = mapModel.Name
			local function cleanupConns(tbl) for _,c in tbl do if c then c:Disconnect() end end end

			local function attachDeathListeners()
				for _, p in Players:GetPlayers() do
					local char = p.Character
					if char and CollectionService:HasTag(char, "Alive") then
						local h = char:FindFirstChildOfClass("Humanoid")
						if h then
							if deathConns[p] then deathConns[p]:Disconnect() end
							deathConns[p] = h.Died:Connect(function()
								CollectionService:RemoveTag(char, "Alive")
								playerDeath(p)
								assignTeam(p, LobbyTeam)
							end)
						end
					end
				end
			end
			attachDeathListeners()

			local charAddedConns = {}
			for _, p in Players:GetPlayers() do
				if charAddedConns[p] then charAddedConns[p]:Disconnect() end
				charAddedConns[p] = p.CharacterAdded:Connect(function(char)
					local h = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 3)
					if h then
						CollectionService:RemoveTag(char, "Alive")
						if deathConns[p] then deathConns[p]:Disconnect() end
						deathConns[p] = h.Died:Connect(function()
							CollectionService:RemoveTag(char, "Alive")
							playerDeath(p)
							assignTeam(p, LobbyTeam)
						end)
					end
					if gameInProgress.Value then assignTeam(p, AliveTeam) else assignTeam(p, LobbyTeam) end
				end)
			end

			local function zombieDeathListeners()
				for _, z in Workspace:GetDescendants() do
					if z:IsA("Model") and z.Name == "Zombie" then
						local h = z:FindFirstChildOfClass("Humanoid")
						if h and not h:GetAttribute("KillTracked") then
							h:SetAttribute("KillTracked", true)
							h.Died:Connect(function()
								local creator = h:FindFirstChild("creator")
								if creator and creator.Value and creator.Value:IsA("Player") then
									playerKill(creator.Value)
								end
								roundStats.totalZombiesKilled += 1
								if zombiesAlive.Value > 0 then zombiesAlive.Value -= 1 end
							end)
						end
					end
				end
			end
			zombieDeathListeners()
			
			-- === Main Game Loop (Improved, Robust, 100% Working) ===
			wave.Value = 1
			local function setupWave(waveNum)
				local zombiesForWave = getZombiesForWave(waveNum, SETTINGS.ZombieMultiplier)
				zombieCount.Value = zombiesForWave
				zombiesAlive.Value = zombiesForWave
				WaveInfo:FireAllClients({current=waveNum, next=waveNum+1, max=maxWave})
				roundMsg.Value = (waveNum == maxWave and "Final Wave") or ("Game In Progress | Wave: "..waveNum.."/"..maxWave.." ("..(maxWave-waveNum+1).." left)")
			end
			setupWave(wave.Value)
			gameInProgress.Value = true
			startSpawnLoop()

			local function badgeAward()
				if not SETTINGS.BadgeEnabled then return end
				for _, p in Players:GetPlayers() do
					local char = p.Character
					if char and CollectionService:HasTag(char, "Alive") then
						local ok, owned = pcall(function() return BadgeService:UserHasBadgeAsync(p.UserId, SETTINGS.BadgeId) end)
						if ok and not owned then pcall(function() BadgeService:AwardBadge(p.UserId, SETTINGS.BadgeId) end) end
					end
				end
			end

			local function giveBonusExp()
				if not AddExp then return end
				local topKillers = getTopKillers()
				for _, uid in topKillers do local p = Players:GetPlayerByUserId(uid) if p then AddExp:FireClient(p, 100) end end
				for uid,s in roundStats.playerStats do if s.Survived then local p = Players:GetPlayerByUserId(uid) if p then AddExp:FireClient(p, 50) end end end
			end

			local function killAllAlive()
				for _, p in Players:GetPlayers() do
					local char = p.Character
					if char and CollectionService:HasTag(char, "Alive") then
						local h = char:FindFirstChildOfClass("Humanoid")
						if h and h.Health > 0 then h.Health = 0 end
					end
				end
			end

			local customMaxWaveConn = SetCustomMaxWave.OnServerEvent:Connect(function(player, value)
				if typeof(value) == "number" and value > 0 then
					maxWave = value
					SetMaxWave:FireAllClients(maxWave)
					WaveInfo:FireAllClients({current=wave.Value, next=wave.Value+1, max=maxWave})
					if wave.Value > maxWave then
						gameInProgress.Value = false
						badgeAward()
						giveBonusExp()
						killAllAlive()
						task.wait(5)
					end
				end
			end)

			local finalWaveMusicPlayed = false
			local finalWaveMsgShow = false

			repeat
				local alive = {}
				for _, p in Players:GetPlayers() do
					if p.Character and CollectionService:HasTag(p.Character, "Alive") then table.insert(alive, p) assignTeam(p, AliveTeam) else assignTeam(p, LobbyTeam) end
				end
				zombieDeathListeners()

				if wave.Value == maxWave and not finalWaveMusicPlayed then
					finalWaveMusicPlayed = true
					local musicIdToPlay = SETTINGS.FinalWaveMusicId
					if mapMusicSound and mapMusicSound:IsA("Sound") then
						mapMusicSound:Stop()
						mapMusicSound.SoundId = musicIdToPlay
						mapMusicSound.TimePosition = 0
						mapMusicSound:Play()
					end
					FinalWaveMusic:FireAllClients(musicIdToPlay)
				end
				if wave.Value == maxWave and not finalWaveMsgShow then
					roundMsg.Value = "Final Wave"
					finalWaveMsgShow = true
				elseif wave.Value ~= maxWave then
					roundMsg.Value = "Game In Progress | Wave: "..wave.Value.."/"..maxWave.." ("..(maxWave-wave.Value+1).." left)"
					finalWaveMsgShow = false
				end
				if #alive > 0 then
					if zombiesAlive.Value <= 0 then
						if wave.Value < maxWave then
							wave.Value += 1
							setupWave(wave.Value)
						else
							gameInProgress.Value = false
							stopSpawnLoop()
							badgeAward()
							giveBonusExp()
							local winnersList = {}
							for _, p in Players:GetPlayers() do
								if p.Character and CollectionService:HasTag(p.Character, "Alive") then
									table.insert(winnersList, p.DisplayName or p.Name)
								end
							end
							local winnersText = #winnersList > 0 and "Winners: " .. table.concat(winnersList, ", ") or "No winners!"
							roundMsg.Value = "Victory! All waves cleared!\n" .. winnersText
							task.wait(5)
						end
					end
				else
					gameInProgress.Value = false
					stopSpawnLoop()
					roundMsg.Value = "Defeat! All players died!"
					task.wait(5)
				end
				task.wait(1)
			until not gameInProgress.Value

			roundStats.endTime = os.clock()
			local roundDuration = math.floor(roundStats.endTime - roundStats.startTime)
			local survivors, winners = {}, {}
			for _, p in Players:GetPlayers() do
				if p.Character and CollectionService:HasTag(p.Character, "Alive") then
					table.insert(survivors, p.UserId)
					playerSurvived(p)
					table.insert(winners, {Name=p.Name, DisplayName=p.DisplayName, UserId=p.UserId})
				end
			end
			local function updateFastest(mapName, duration, survivors)
				if not mapName then return end
				if not roundStats.fastestRound[mapName] or duration < roundStats.fastestRound[mapName].time then
					roundStats.fastestRound[mapName] = {time=duration, userIds=survivors}
				end
			end
			if #survivors > 0 then updateFastest(roundStats.mapName, roundDuration, survivors) end

			local statsSummary = {
				TotalZombiesKilled = roundStats.totalZombiesKilled,
				RoundDuration = roundDuration,
				PlayerStats = roundStats.playerStats,
				FastestRound = roundStats.fastestRound[roundStats.mapName],
				Map = roundStats.mapName, Time = os.time(),
			}
			RoundWinners:FireAllClients(winners, statsSummary)
			_G.RoundHistory = _G.RoundHistory or {}
			table.insert(_G.RoundHistory, 1, statsSummary)
			if #_G.RoundHistory > 10 then table.remove(_G.RoundHistory, #_G.RoundHistory) end
			RoundStatsSummary:FireAllClients({History = _G.RoundHistory})

			for uid,s in roundStats.playerStats do
				if s.Survived then
					local p = Players:GetPlayerByUserId(uid)
					if p then
						local ls = p:FindFirstChild("leaderstats")
						if ls then local w = ls:FindFirstChild("Wins") if w then w.Value += 1 end end
					end
				end
			end

			local mvpUserId, mvpStats, mk = nil, nil, -1
			for uid,s in roundStats.playerStats do
				if s.Kills > mk then mk = s.Kills; mvpUserId = uid; mvpStats = s
				elseif s.Kills == mk and s.Deaths < (mvpStats and mvpStats.Deaths or math.huge) then mvpUserId = uid; mvpStats = s
				end
			end
			if mvpUserId then
				local mvpPlayer = Players:GetPlayerByUserId(mvpUserId)
				if mvpPlayer then
					RoundMVP:FireAllClients({
						UserId=mvpUserId, Name=mvpPlayer.Name, DisplayName=mvpPlayer.DisplayName,
						Kills=mvpStats.Kills, Deaths=mvpStats.Deaths, Survived=mvpStats.Survived,
					})
				end
			end

			local playerStatsSummary = {}
			for uid,s in roundStats.playerStats do
				local p = Players:GetPlayerByUserId(uid)
				if p then
					playerStatsSummary[uid] = {
						Name=p.Name, DisplayName=p.DisplayName, Kills=s.Kills, Deaths=s.Deaths,
						Survived=s.Survived, WinStreak=getPlayerWinStreak(p)
					}
				end
			end
			RoundStatsSummary:FireAllClients(playerStatsSummary)
			for uid,s in roundStats.playerStats do
				if s.Deaths == 0 and s.Kills > 0 then
					local p = Players:GetPlayerByUserId(uid)
					if p and AddExp then AddExp:FireClient(p, 50) end
				end
			end

			roundMsg.Value = "Round Over! Returning to lobby soon..."
			task.wait(2)
			killAllAlive()
			task.wait(2)
			-- Clear map and zombies robustly
			mapContainer:ClearAllChildren()
			pcall(function() ZombieManager:ClearZombies() end)
			for _, p in Players:GetPlayers() do
				if p.Character then
					CollectionService:RemoveTag(p.Character, "Alive")
					CollectionService:RemoveTag(p.Character, "PlayerZombie")
					local h = p.Character:FindFirstChildOfClass("Humanoid")
					if h then h.WalkSpeed = 16; h.MaxHealth = 100; h.Health = h.MaxHealth; h.JumpPower = 50 end
				end
				p:SetAttribute("IsPlayerZombie", false)
				p:SetAttribute("IsJuggernaut", false)
				assignTeam(p, LobbyTeam)
			end
			cleanupConns(deathConns)
			cleanupConns(charAddedConns)
			if customMaxWaveConn then customMaxWaveConn:Disconnect() end
		else
			roundMsg.Value = "Error loading map, restarting..."
			task.wait(5)
		end
	else
		roundMsg.Value = "No maps available!"
		task.wait(5)
	end
	task.wait(1)
end