local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local InsertService = game:GetService("InsertService")
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")

local PerkManager = require(ServerScriptService.GameScript.Modules.PerksController)
local Data = require(script.Parent.Parent.DataModule)
local RagdollService = require(script:WaitForChild("RagdollService"))
local Constants = require(ReplicatedStorage:WaitForChild("Constants"))

local GameFunctionsFolder = script.Parent.Parent:WaitForChild("GameFunctions")
local GameFunctions = {
	Chance = require(GameFunctionsFolder:WaitForChild("Chance")),
	GiveWeapon = require(GameFunctionsFolder:WaitForChild("GiveWeapon")),
	GunDrop = require(GameFunctionsFolder:WaitForChild("GunDrop")),
	StandardFunctions = require(GameFunctionsFolder:WaitForChild("StandardFunctions")),
}

local Database = ReplicatedStorage:WaitForChild("Database")
local Sync = require(Database:WaitForChild("Sync"))
local GameplayRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay")
local Gets = script.Parent.Parent:WaitForChild("Get")

local GameMode = {}
local RoleData = {}
local Victims = {}
local randomGenerator = Random.new()

local CONFIG = {
	WalkSpeed = 16,
	SpawnYOffset = 3.2,
	DefaultKnifeAssetId = 196750384,
	DefaultGunAssetId = 196751820,
	CorpseLifetime = false,
	Ragdoll = {
		ServerOwned = true,
		DisableCorpseTouch = true,
		DisableCorpseQueries = false,
		Debug = false,
		FreezeWhenSettled = true,
		MinimumFreezeDelay = 1.5,
		MaximumFreezeDelay = 5,
		SettleDuration = 0.6,
		LinearVelocityThreshold = 0.35,
		AngularVelocityThreshold = 0.8,
		DisableConstraintsWhenFrozen = true,
	},
}

local isVipServer = game.VIPServerId ~= ""

_G.LastRoundRewards = _G.LastRoundRewards or {}
_G.RoundCounter = _G.RoundCounter or 0
_G.OutfitsDisabled = true

local function warnf(message, ...)
	warn(string.format("[ClassicGameMode] " .. message, ...))
end

local function clearStoredForcedRole(roleName)
	local folder = ServerStorage:FindFirstChild("ForcedRoles")
	local value = folder and folder:FindFirstChild(roleName)
	if value and value:IsA("StringValue") then
		value.Value = ""
	end
end

local function invokeGetter(name)
	local getter = Gets:FindFirstChild(name)
	if not getter or not getter:IsA("BindableFunction") then
		warnf("Missing BindableFunction getter: %s", tostring(name))
		return nil
	end

	local success, result = pcall(function()
		return getter:Invoke()
	end)

	if not success then
		warnf("Getter %s failed: %s", tostring(name), tostring(result))
		return nil
	end

	return result
end

local function safeDataGet(player, key, fallback)
	if not player then
		return fallback
	end

	local success, result = pcall(Data.Get, player, key)
	if not success or result == nil then
		if not success then
			warnf("Data.Get failed for %s/%s: %s", player.Name, tostring(key), tostring(result))
		end
		return fallback
	end

	return result
end

local function safeCall(label, callback)
	local success, result = pcall(callback)
	if not success then
		warnf("%s failed: %s", label, tostring(result))
	end
	return success, result
end

local function resolvePlayer(value)
	if typeof(value) == "Instance" and value:IsA("Player") then
		return value.Parent == Players and value or nil
	end

	if type(value) == "string" then
		return Players:FindFirstChild(value)
	end

	return nil
end

local function isRoundEligiblePlayer(player)
	if not player or player.Parent ~= Players then
		return false
	end

	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	return character ~= nil and humanoid ~= nil and humanoid.Health > 0
end

local function copyArray(source)
	local result = {}
	for _, value in ipairs(source) do
		table.insert(result, value)
	end
	return result
end

local function shuffle(array)
	for index = #array, 2, -1 do
		local swapIndex = randomGenerator:NextInteger(1, index)
		array[index], array[swapIndex] = array[swapIndex], array[index]
	end
	return array
end

local function buildEmptyRewardPacket(playerDataSnapshot, winCondition, shooterName, was1v1, coins)
	return {
		RoundCount = _G.RoundCounter,
		GameModeName = GameMode.Name,
		PlayerData = playerDataSnapshot,
		WinCondition = winCondition,
		Shooter = shooterName,
		Was1v1 = was1v1,
		Coins = coins,

		Rewards = {
			XPRewards = {},
			TotalEarnedXP = 0,
		},

		XPRewards = {},
		TotalEarnedXP = 0,
	}
end

local function createServerRagdoll(victim, victimHumanoid)
	if not victim or not victimHumanoid or not victimHumanoid:IsA("Humanoid") then
		return nil
	end

	local options = table.clone(CONFIG.Ragdoll)
	options.Lifetime = CONFIG.CorpseLifetime

	local success, result = pcall(RagdollService.Create, victim, victimHumanoid, options)
	if not success then
		warnf("Could not create ragdoll for %s: %s", victim.Name, tostring(result))
		return nil
	end

	return result
end

local function killHumanoid(humanoid)
	if not humanoid or not humanoid:IsA("Humanoid") or humanoid.Health <= 0 then
		return false
	end

	humanoid.BreakJointsOnDeath = false
	humanoid.Health = 0
	return true
end

local function markCharacterAlive(character)
	if not character then
		return
	end

	character:SetAttribute("ServerRagdolled", nil)
	character:SetAttribute("CreatingServerRagdoll", nil)

	local success, err = pcall(RagdollService.MarkCharacterAlive, character)
	if not success then
		warnf("MarkCharacterAlive failed for %s: %s", character.Name, tostring(err))
	end
end

local function getGameTimer()
	return math.max(tonumber(invokeGetter("GameTimer")) or 0, 0)
end

local function countCiviliansAlive(playerData)
	local count = 0
	for _, data in pairs(playerData or {}) do
		if (data.Role == "Innocent" or data.Role == "Sheriff" or data.Role == "Hero") and data.Dead == false then
			count += 1
		end
	end
	return count
end

local function isMurdererAlive(playerData)
	for _, data in pairs(playerData or {}) do
		if data.Role == "Murderer" and data.Dead == false then
			return true
		end
	end
	return false
end

local function setPlayerDead(playerData, killedBy, killType)
	if not playerData or playerData.Dead then
		return false
	end

	playerData.Dead = true
	playerData.DeadTime = getGameTimer()

	if killedBy then
		playerData.Killed = true
		playerData.KilledBy = killedBy.Name
		playerData.KilledByUserId = killedBy.UserId
		playerData.KillType = killType
	end

	return true
end

local function ragdollAndKill(player, humanoid)
	if not player or not humanoid then
		return
	end

	local character = humanoid.Parent
	if character and not character:GetAttribute("ServerRagdolled") then
		createServerRagdoll(player, humanoid)
	end

	killHumanoid(humanoid)
end

local function broadcastPlayerData(playerData)
	local remote = GameplayRemotes:FindFirstChild("PlayerDataChanged")
	if remote and remote:IsA("RemoteEvent") then
		remote:FireAllClients(playerData)
	end
end

local function dropSheriffGunIfNeeded(player, playerData)
	if _G.RoundEnded or not player or not playerData then
		return
	end

	local data = playerData[player.Name]
	if not data or (data.Role ~= "Sheriff" and data.Role ~= "Hero") then
		return
	end

	if GameFunctions.StandardFunctions.CiviliansAlive(playerData) < 1 then
		return
	end

	safeCall("Drop sheriff gun", function()
		GameFunctions.GunDrop.Drop(player)
	end)
end

local function addCreatorTag(humanoid, killer, killType)
	local oldCreator = humanoid:FindFirstChild("Creator")
	local oldCreator2 = humanoid:FindFirstChild("Creator2")
	if oldCreator then
		oldCreator:Destroy()
	end
	if oldCreator2 then
		oldCreator2:Destroy()
	end

	local creatorTag = Instance.new("ObjectValue")
	creatorTag.Name = killType == "Throwing" and "Creator2" or "Creator"
	creatorTag.Value = killer
	creatorTag.Parent = humanoid
	Debris:AddItem(creatorTag, 5)
end

local function playKnifeKillSound(killer)
	local knife = killer:FindFirstChild("Knife")
		or (killer.Character and killer.Character:FindFirstChild("Knife"))
	local handle = knife and knife:FindFirstChild("Handle")
	local sound = handle and handle:FindFirstChild("Kill")

	if sound and sound:IsA("Sound") then
		sound:Play()
	end
end

local function playGunKillSound(killer)
	local root = killer.Character and killer.Character:FindFirstChild("HumanoidRootPart")
	local soundTemplate = script:FindFirstChild("GunKill")
	if not root or not soundTemplate or not soundTemplate:IsA("Sound") then
		return
	end

	local sound = soundTemplate:Clone()
	sound.Parent = root
	sound:Play()
	Debris:AddItem(sound, math.max(sound.TimeLength, 3) + 0.5)
end

local function positionInstance(instance, targetCFrame)
	if instance:IsA("BasePart") then
		instance.CFrame = targetCFrame
	elseif instance:IsA("Model") then
		instance:PivotTo(targetCFrame)
	else
		local part = instance:FindFirstChildWhichIsA("BasePart", true)
		if part then
			part.CFrame = targetCFrame
		end
	end
end

local function setCharacterNetworkOwnership(character, serverOwned)
	if not character then
		return
	end

	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") and not descendant.Anchored then
			pcall(function()
				if serverOwned then
					descendant:SetNetworkOwner(nil)
				else
					descendant:SetNetworkOwnershipAuto()
				end
			end)
		end
	end
end

local function zeroCharacterVelocity(character)
	if not character then
		return
	end

	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") and not descendant.Anchored then
			descendant.AssemblyLinearVelocity = Vector3.zero
			descendant.AssemblyAngularVelocity = Vector3.zero
		end
	end
end

local function stabilizeSpawnedCharacter(player, character, humanoid)
	if not player or not character or not humanoid then
		return
	end

	local previousAutoRotate = humanoid.AutoRotate
	setCharacterNetworkOwnership(character, true)
	zeroCharacterVelocity(character)
	humanoid.AutoRotate = false
	humanoid.WalkSpeed = 0

	task.delay(0.65, function()
		if player.Parent ~= Players or player.Character ~= character or not character.Parent then
			return
		end

		markCharacterAlive(character)
		zeroCharacterVelocity(character)
		humanoid.WalkSpeed = CONFIG.WalkSpeed
		humanoid.AutoRotate = previousAutoRotate
		setCharacterNetworkOwnership(character, false)
	end)
end

local function emitConfetti(position)
	local gameplayStorage = ServerStorage:FindFirstChild("Gameplay")
	local template = gameplayStorage and gameplayStorage:FindFirstChild("ConfettiCannon")
	if not template then
		return
	end

	local confetti = template:Clone()
	confetti.Parent = Workspace
	positionInstance(confetti, CFrame.new(position))

	for _, descendant in ipairs(confetti:GetDescendants()) do
		if descendant:IsA("ParticleEmitter") then
			descendant.Enabled = true
		end
	end

	task.delay(0.3, function()
		if not confetti.Parent then
			return
		end

		for _, descendant in ipairs(confetti:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") then
				descendant.Enabled = false
			end
		end

		Debris:AddItem(confetti, 1)
	end)
end

local function getDefaultWeaponModel(name)
	local database = ServerStorage:WaitForChild("Database")
	local defaults = database:WaitForChild("Default")
	local template = defaults:FindFirstChild(name)
	return template and template:Clone() or nil
end

local function getEquippedAssetId(player, weaponType, defaultAssetId)
	local weapons = safeDataGet(player, "Weapons", {})
	local equipped = type(weapons) == "table" and weapons.Equipped or nil
	local itemName = type(equipped) == "table" and equipped[weaponType] or nil
	local itemData = itemName and Sync.Item and Sync.Item[itemName] or nil
	return tonumber(itemData and itemData.ItemID) or defaultAssetId
end

local function loadAssetOrFallback(assetId, fallback, label)
	local success, result = pcall(function()
		local container = InsertService:LoadAsset(assetId)
		local children = container:GetChildren()
		local loaded = children[1]

		if loaded then
			loaded.Parent = nil
		end
		container:Destroy()

		return loaded
	end)

	if success and result then
		if fallback then
			fallback:Destroy()
		end
		return result
	end

	if not success then
		warnf("Could not load %s asset %s; using default: %s", label, tostring(assetId), tostring(result))
	end
	return fallback
end

local function chooseWeightedMurderer()
	local weightedCandidates = {}
	local totalWeight = 0

	for _, chanceData in pairs(GameFunctions.Chance.Chances or {}) do
		if type(chanceData) == "table" then
			local candidate = resolvePlayer(chanceData.Player)
			local weight = math.max(tonumber(chanceData.Chance) or 0, 0)

			if isRoundEligiblePlayer(candidate) and weight > 0 then
				totalWeight += weight
				table.insert(weightedCandidates, {
					Player = candidate,
					CumulativeWeight = totalWeight,
				})
			end
		end
	end

	if totalWeight > 0 then
		local roll = randomGenerator:NextNumber(0, totalWeight)
		for _, entry in ipairs(weightedCandidates) do
			if roll <= entry.CumulativeWeight then
				return entry.Player
			end
		end
	end

	local success, chanceTable = pcall(GameFunctions.Chance.CreateChanceTable)
	if success and type(chanceTable) == "table" and #chanceTable > 0 then
		local validEntries = {}
		for _, value in ipairs(chanceTable) do
			local candidate = resolvePlayer(value)
			if isRoundEligiblePlayer(candidate) then
				table.insert(validEntries, candidate)
			end
		end

		if #validEntries > 0 then
			return validEntries[randomGenerator:NextInteger(1, #validEntries)]
		end
	end

	local eligiblePlayers = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if isRoundEligiblePlayer(player) then
			table.insert(eligiblePlayers, player)
		end
	end

	if #eligiblePlayers > 0 then
		return eligiblePlayers[randomGenerator:NextInteger(1, #eligiblePlayers)]
	end

	return nil
end

local function getWinningShooterName(playerData)
	if type(_G.MurdererShooter) ~= "string" then
		return nil
	end

	local shooterData = playerData and playerData[_G.MurdererShooter]
	if not shooterData or shooterData.Dead == true then
		return nil
	end

	if shooterData.Role ~= "Sheriff" and shooterData.Role ~= "Hero" then
		return nil
	end

	return _G.MurdererShooter
end

local function updatePersistentRoundStats(player, role, stats)

	if isVipServer then
		return
	end

	for statName, amount in pairs(stats) do
		if amount > 0 then
			safeCall("Data.GiveStatus(" .. statName .. ")", function()
				Data.GiveStatus(player, statName, amount)
			end)
		end
	end

	if role == "Murderer" then
		safeCall("Chance.Reset", function()
			GameFunctions.Chance.Reset(player.Name)
		end)
	else
		safeCall("Chance.Increase", function()
			GameFunctions.Chance.Increase(player.Name)
		end)
	end
end

GameMode.Name = "Classic"
GameMode.Outfits = "Map"
GameMode.Coins = true
GameMode.PlayerData = {}
GameMode.RoleSelectWait = 15
GameMode.MurdererEliminations = 0
GameMode.RewardsData = {}

function GameMode.GetRoleData()
	return RoleData
end

function GameMode.DoRoles()
	table.clear(Victims)
	table.clear(RoleData)
	_G.MurdererWasShot = false
	_G.MurdererShooter = nil

	local customMurderer = resolvePlayer(_G.CustomMurderer)
	if customMurderer and not isRoundEligiblePlayer(customMurderer) then
		customMurderer = nil
	end

	local selectedMurderer = customMurderer or chooseWeightedMurderer()
	_G.CustomMurderer = nil
	clearStoredForcedRole("Murderer")

	if not selectedMurderer then
		warnf("No eligible player could be selected as Murderer")
		return nil
	end

	RoleData.Murderer = selectedMurderer
	RoleData.MurdererName = selectedMurderer.Name

	local sheriffCandidates = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= selectedMurderer and isRoundEligiblePlayer(player) then
			table.insert(sheriffCandidates, player)
		end
	end

	local customSheriff = resolvePlayer(_G.CustomSheriff)
	if customSheriff == selectedMurderer or not isRoundEligiblePlayer(customSheriff) then
		customSheriff = nil
	end

	if customSheriff then
		RoleData.Sheriff = customSheriff
	elseif #sheriffCandidates > 0 then
		RoleData.Sheriff = sheriffCandidates[randomGenerator:NextInteger(1, #sheriffCandidates)]
	end
	_G.CustomSheriff = nil
	clearStoredForcedRole("Sheriff")

	local knifeFallback = getDefaultWeaponModel("Knife")
	local gunFallback = getDefaultWeaponModel("Gun")
	local knifeAssetId = getEquippedAssetId(RoleData.Murderer, "Knife", CONFIG.DefaultKnifeAssetId)
	local gunAssetId = getEquippedAssetId(RoleData.Sheriff, "Gun", CONFIG.DefaultGunAssetId)

	RoleData.MurdererKnife = loadAssetOrFallback(knifeAssetId, knifeFallback, "knife")
	RoleData.SheriffGun = loadAssetOrFallback(gunAssetId, gunFallback, "gun")

	return RoleData
end

function GameMode.SpawnPlayers()
	local map = invokeGetter("Map")
	local spawnsFolder = map and map:FindFirstChild("Spawns")
	if not spawnsFolder then
		warnf("Cannot spawn players because the current map has no Spawns folder")
		return
	end

	local spawnPoints = {}
	for _, spawnPoint in ipairs(spawnsFolder:GetChildren()) do
		if spawnPoint:IsA("BasePart") then
			table.insert(spawnPoints, spawnPoint)
		end
	end

	if #spawnPoints == 0 then
		warnf("Cannot spawn players because the map has no BasePart spawns")
		return
	end

	shuffle(spawnPoints)
	Workspace:SetAttribute("Gamemode", GameMode.Name)

	local spawnIndex = 1
	for _, player in ipairs(Players:GetPlayers()) do
		local playerData = GameMode.PlayerData[player.Name]
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if playerData and character and humanoid then
			local spawnPoint = spawnPoints[spawnIndex]
			spawnIndex = spawnIndex % #spawnPoints + 1

			local success, err = pcall(function()
				Data.CreatePlayerAttributes(player)
				markCharacterAlive(character)
				setCharacterNetworkOwnership(character, true)
				zeroCharacterVelocity(character)
				humanoid.WalkSpeed = 0
				character:PivotTo(spawnPoint.CFrame + Vector3.new(0, CONFIG.SpawnYOffset, 0))
				zeroCharacterVelocity(character)
				stabilizeSpawnedCharacter(player, character, humanoid)
			end)

			if not success then
				warnf("Failed to spawn %s: %s", player.Name, tostring(err))
			end
		end
	end
end

function GameMode.GiveWeapons()
	for _, player in ipairs(Players:GetPlayers()) do
		local playerData = GameMode.PlayerData[player.Name]
		if not playerData or playerData.Dead then
			continue
		end

		Data.CreatePlayerAttributes(player)
		markCharacterAlive(player.Character)
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if character and humanoid then
			setCharacterNetworkOwnership(character, true)
			zeroCharacterVelocity(character)
			task.delay(0.35, function()
				if player.Parent == Players and player.Character == character and character.Parent then
					markCharacterAlive(character)
					zeroCharacterVelocity(character)
					setCharacterNetworkOwnership(character, false)
				end
			end)
		end

		if playerData.Role == "Murderer" then
			safeCall("Give murderer knife", function()
				GameFunctions.GiveWeapon.Knife(player)
			end)

			local equippedPerk = playerData.Effect
			if equippedPerk then
				safeCall("Initialize murderer perk", function()
					PerkManager.new(player, equippedPerk)
				end)
			end
		elseif playerData.Role == "Sheriff" then
			safeCall("Give sheriff gun", function()
				GameFunctions.GiveWeapon.Gun(player)
			end)
		end
	end
end

function GameMode.Died(player)
	_G.OutfitsDisabled = true
	if not player or not player:IsA("Player") then
		return
	end

	local playerData = GameMode.PlayerData[player.Name]
	local markedDead = setPlayerDead(playerData)
	if markedDead then
		dropSheriffGunIfNeeded(player, GameMode.PlayerData)
	end

	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if humanoid and character and not character:GetAttribute("ServerRagdolled") then
		createServerRagdoll(player, humanoid)
	end
end

function GameMode.KnifeKill(killer, victim, victimHumanoid, killType, playerData)
	playerData = playerData or GameMode.PlayerData
	killType = tostring(killType or "Knife")

	if not killer or not killer:IsA("Player")
		or not victim or not victim:IsA("Player")
		or killer == victim
		or not victimHumanoid or not victimHumanoid:IsA("Humanoid")
		or victimHumanoid.Health <= 0
	then
		return false
	end

	local killerData = playerData[killer.Name]
	local victimData = playerData[victim.Name]
	if not killerData or not victimData or victimData.Dead then
		return false
	end

	if not setPlayerDead(victimData, killer, killType) then
		return false
	end
	dropSheriffGunIfNeeded(victim, playerData)

	killerData.Eliminations = math.max(tonumber(killerData.Eliminations) or 0, 0) + 1
	GameMode.MurdererEliminations = killerData.Eliminations

	addCreatorTag(victimHumanoid, killer, killType)
	playKnifeKillSound(killer)
	ragdollAndKill(victim, victimHumanoid)
	broadcastPlayerData(playerData)

	return true
end

function GameMode.GunKill(killer, victim, victimHumanoid, playerData)
	playerData = playerData or GameMode.PlayerData

	if not killer or not killer:IsA("Player")
		or not victim or not victim:IsA("Player")
		or killer == victim
		or not victimHumanoid or not victimHumanoid:IsA("Humanoid")
		or victimHumanoid.Health <= 0
	then
		return false
	end

	local killerData = playerData[killer.Name]
	local victimData = playerData[victim.Name]
	if not killerData or not victimData or victimData.Dead then
		return false
	end

	if victimData.Role ~= "Murderer" then
		if setPlayerDead(victimData, killer, "GunMisfire") then
			dropSheriffGunIfNeeded(victim, playerData)
		end
		if killerData and setPlayerDead(killerData) then
			dropSheriffGunIfNeeded(killer, playerData)
		end

		ragdollAndKill(victim, victimHumanoid)

		local killerHumanoid = killer.Character and killer.Character:FindFirstChildOfClass("Humanoid")
		if killerHumanoid then
			ragdollAndKill(killer, killerHumanoid)
		end

		broadcastPlayerData(playerData)
		return true
	end

	if not setPlayerDead(victimData, killer, "Gun") then
		return false
	end

	_G.MurdererWasShot = true
	_G.MurdererShooter = killer.Name

	safeCall("Record sheriff status", function()
		Data.GiveStatus(killer, "Sheriffs")
	end)

	playGunKillSound(killer)

	local character = victimHumanoid.Parent
	local torso = character and (
		character:FindFirstChild("UpperTorso")
			or character:FindFirstChild("Torso")
			or character:FindFirstChild("HumanoidRootPart")
	)
	if torso and torso:IsA("BasePart") then
		emitConfetti(torso.Position)
	end

	ragdollAndKill(victim, victimHumanoid)
	broadcastPlayerData(playerData)
	return true
end

function GameMode.EndConditions()
	local playerData = GameMode.PlayerData
	if not next(playerData) then
		playerData = invokeGetter("PlayerData") or {}
	end

	local hasInnocents = GameFunctions.StandardFunctions.CheckForInnocents(playerData)
	if hasInnocents == false then
		return true
	end

	for _, data in pairs(playerData) do
		if data.Role == "Murderer" then
			return data.Dead == true
		end
	end

	return RoleData.MurdererName ~= nil and Players:FindFirstChild(RoleData.MurdererName) == nil
end

function GameMode.GeneratePlayerData()
	table.clear(GameMode.PlayerData)
	GameMode.MurdererEliminations = 0

	local codeNames = {}
	local colors = {}
	if game.PlaceId == Constants.Places.Disguises then
		codeNames = copyArray(require(ServerStorage.Gameplay.CodeNames))
		colors = copyArray(require(ServerStorage.Gameplay.Colors))
		shuffle(codeNames)
		shuffle(colors)
	end

	local disguiseIndex = 1
	for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character
		if not character then
			continue
		end

		player.HealthDisplayDistance = 0
		player.NameDisplayDistance = 0

		local role = "Innocent"
		if player == RoleData.Murderer then
			role = "Murderer"
		elseif player == RoleData.Sheriff then
			role = "Sheriff"
		end

		local newXP = tonumber(safeDataGet(player, "NewXP", 0)) or 0
		local level = 0
		safeCall("Data.GetLevel", function()
			level = tonumber(Data.GetLevel(newXP)) or 0
		end)

		local weapons = safeDataGet(player, "Weapons", {})
		local weaponEquipped = type(weapons) == "table" and weapons.Equipped or {}
		local perks = safeDataGet(player, "Perks", {})
		local perkEquipped = type(perks) == "table" and perks.Equipped or {}
		local isElite = player:GetAttribute("Elite") == true
		local maxCoins = isElite and 50 or (level >= 40 and 40 or 35)

		local data = {
			Role = role,
			Dead = false,
			DeadTime = nil,
			Killed = false,
			KilledBy = nil,
			KilledByUserId = nil,
			KillType = nil,
			NewXP = newXP,
			Knife = weaponEquipped.Knife,
			Gun = weaponEquipped.Gun,
			Coins = 0,
			Eliminations = 0,
			MaxCoins = maxCoins,
			Effect = perkEquipped[1],
			XP = tonumber(safeDataGet(player, "XP", 0)) or 0,
		}

		if game.PlaceId == Constants.Places.Disguises then
			if #codeNames > 0 then
				data.CodeName = codeNames[(disguiseIndex - 1) % #codeNames + 1]
			end
			if #colors > 0 then
				data.Color = BrickColor.new(colors[(disguiseIndex - 1) % #colors + 1])
			end
			disguiseIndex += 1
		end

		GameMode.PlayerData[player.Name] = data
	end

	return GameMode.PlayerData
end

function GameMode.ConvertInteger(seconds)
	seconds = math.max(math.floor(tonumber(seconds) or 0), 0)
	local minutes = math.floor(seconds / 60)
	local remainingSeconds = seconds % 60
	local parts = {}

	if minutes > 0 then
		table.insert(parts, string.format("%d minute%s", minutes, minutes == 1 and "" or "s"))
	end

	if remainingSeconds > 0 or #parts == 0 then
		table.insert(parts, string.format(
			"%d second%s",
			remainingSeconds,
			remainingSeconds == 1 and "" or "s"
			))
	end

	return table.concat(parts, " ")
end

function GameMode.GetVictoryData(playerData)
	playerData = playerData or GameMode.PlayerData
	local timer = getGameTimer()
	local civiliansAlive = countCiviliansAlive(playerData)
	local murdererAlive = isMurdererAlive(playerData)

	if civiliansAlive <= 0 and murdererAlive then
		return "MurdererWin", "Murderer"
	end

	if RoleData.MurdererName and not Players:FindFirstChild(RoleData.MurdererName) then
		return "Innocents", "Innocent"
	end

	if not murdererAlive then
		local shooterName = _G.MurdererWasShot and getWinningShooterName(playerData) or nil
		local shooterData = shooterName and playerData[shooterName]

		if shooterData and shooterData.Role == "Sheriff" then
			return "SheriffWin", "Sheriff"
		elseif shooterData and shooterData.Role == "Hero" then
			return "MurdererDied", "Hero"
		end

		return "Innocents", "Innocent"
	end

	if timer <= 0 then
		return "Time", "Innocent"
	end

	return nil, nil
end

function GameMode.Reward(_, playerData, _timerData, _timeLeft, winCondition)
	playerData = playerData or GameMode.PlayerData

	local playerRewards = {}
	local shooterName = _G.MurdererWasShot and getWinningShooterName(playerData) or nil
	local civiliansAlive = countCiviliansAlive(playerData)
	local was1v1 = civiliansAlive == 1

	_G.RoundCounter += 1

	for playerName, data in pairs(playerData) do
		local player = Players:FindFirstChild(playerName)
		if not player then
			continue
		end

		local role = data.Role
		local isAlive = data.Dead == false
		local stats = {
			Eliminations = 0,
			Victories = 0,
			Survivals = 0,
		}


		if role == "Murderer" then
			stats.Eliminations = math.max(tonumber(data.Eliminations) or 0, 0)
			if winCondition == "MurdererWin" then
				stats.Victories = 1
			end
		elseif role == "Sheriff" then
			if winCondition == "SheriffWin" and isAlive then
				stats.Victories = 1
			end

			if isAlive and winCondition ~= "MurdererWin" then
				stats.Survivals = 1
			end
		elseif role == "Hero" or shooterName == playerName then
			if shooterName == playerName and _G.MurdererWasShot and winCondition ~= "Innocents" then
				stats.Victories = 1
			end

			if isAlive and winCondition ~= "MurdererWin" then
				stats.Survivals = 1
			end
		elseif role == "Innocent" and isAlive and winCondition ~= "MurdererWin" then
			stats.Survivals = 1
		end

		local coins = math.max(tonumber(data.Coins) or 0, 0)
		local snapshot = table.clone(data)

		playerRewards[playerName] = buildEmptyRewardPacket(
			snapshot,
			winCondition,
			shooterName,
			was1v1,
			coins
		)

		updatePersistentRoundStats(player, role, stats)

		if _G.LiveBoardRecordWin then
			if role == "Murderer" and winCondition == "MurdererWin" then
				_G.LiveBoardRecordWin(player, "Murderer", 1)
			elseif role == "Sheriff" and stats.Victories > 0 then
				_G.LiveBoardRecordWin(player, "Sheriff", 1)
			elseif role == "Innocent" and stats.Survivals > 0 then
				_G.LiveBoardRecordWin(player, "Innocent", 1)
			end
		end
	end

	playerRewards.WinCondition = winCondition
	playerRewards.RoundCount = _G.RoundCounter
	playerRewards.Shooter = shooterName
	playerRewards.Was1v1 = was1v1
	GameMode.RewardsData = playerRewards
	_G.LastRoundRewards = playerRewards

	return playerRewards
end

GameMode.MakeCharacter = require(script:WaitForChild("MakeCharacter"))
RagdollService.Initialize()

return GameMode