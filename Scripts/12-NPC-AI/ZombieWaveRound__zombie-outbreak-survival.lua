-- Reference copy for study. Game: zombie-outbreak-survival
-- Original: ServerScriptService/Game Round.server.lua  (Script, 665 lines)
-- What it does: Wave spawner: zombies per wave = base * wave * multiplier, a timed spawn loop over tagged Spawner parts, and a round loop that advances the wave when all zombies die, ends in victory on the last wave or defeat when no players are alive.
-- Excerpt of lines 1-27, 145-260, 446-558 (code between the ranges was left out; the code itself is unchanged)

-- ===== lines 1-27 =====
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

-- ===== lines 145-260 =====
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

-- ===== lines 446-558 =====
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

