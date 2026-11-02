local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local DataService = require(ReplicatedStorage.Packages.DataService).server
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local GameplayServiceUtils = require(ReplicatedStorage.Source.Features.Gameplay.GameplayServiceUtils)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local TutorialServiceUtils = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceUtils)
local Zones = require(ReplicatedStorage.Source.Game.Items.Zones)
local EnemyMutations = require(ReplicatedStorage.Source.Features.Gameplay.EnemyMutations)

local SLIME_STATES = GameplayServiceUtils.enums.slimeStates
local ENEMY_STATES = GameplayServiceUtils.enums.enemyStates
local Enemies = require(ReplicatedStorage.Source.Game.Items.Enemies)

local networkerModule = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
local remotes031 = nil

local GameplayService = {}
local playerGameplays = {}
local nextEnemyId = 0
local usedGameplayIds = {}

local function getMaxEnemies(upgrades)
	local maxVal = 1 

	local countTable = {
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5,
		[6] = 6,
		[7] = 7,
	}

	for level, value in pairs(countTable) do
		local key = "enemyCount" .. tostring(level)
		if upgrades[key] == true then
			maxVal = math.max(maxVal, value)
		end
	end

	return maxVal
end

local function fireClient(gameplay, method, ...)
	local re = gameplay.remoteEvent
	if re then
		re:FireClient(gameplay.player, method, ...)
	end
end

local function pickAvailableGameplayId()
	if not remotes031 then return nil, nil end
	for _, child in ipairs(remotes031:GetChildren()) do
		local name = child.Name
		if string.sub(name, 1, 8) == "Gameplay" and name ~= "GameplayService" then
			local num = tonumber(string.sub(name, 9))
			if num and not usedGameplayIds[num] then
				local re = child:FindFirstChild("RemoteEvent")
				if re then
					return num, re
				end
			end
		end
	end
	return nil, nil
end

local function getEnemyIdForZone(zoneId: number): number
	local zoneId_clamped = math.clamp(math.floor(zoneId), 1, 25)
	local ok, zoneInfo = pcall(Zones.getZone, zoneId_clamped)
	if ok and zoneInfo and zoneInfo.enemies and #zoneInfo.enemies > 0 then
		return zoneInfo.enemies[math.random(1, #zoneInfo.enemies)]
	end
	return zoneId_clamped
end

local function getEnemyStats(enemyId, mutations)
	local info = Enemies.getEnemyInfo(enemyId)
	local baseHealth = info and info.health or 20
	local baseDamage = info and info.damage or 1
	local baseSpeed  = info and info.speed  or 12
	if mutations then
		local mods = EnemyMutations.getSpawnModifiers(mutations)
		baseHealth = math.round(baseHealth * mods.healthMultiplier)
		baseDamage = math.round(baseDamage * mods.damageMultiplier)
		baseSpeed  = math.round(baseSpeed  * (mods.speedMultiplier or 1))
	end
	return { health = baseHealth, damage = baseDamage, speed = baseSpeed }
end

local function anySlimeInCombat(gameplay)
	for _, slime in pairs(gameplay.slimeMap) do
		if slime.state == SLIME_STATES.targeting or slime.state == SLIME_STATES.attacking then
			return true
		end
	end
	return false
end

local function computeSlimeStats(uniqueId, rawData)
	local ok1, slimeData = pcall(InventoryServiceUtils.getSlimeData, uniqueId, rawData)
	if not ok1 or not slimeData then
		return { health = 100, maxHealth = 100, speed = 30, damage = 10 }
	end
	local ok2, stats = pcall(InventoryServiceUtils.getSlimeStatsFromData, slimeData)
	if not ok2 or not stats then
		return { health = 100, maxHealth = 100, speed = 30, damage = 10 }
	end
	return stats
end

local function snapshotKey(rawData)
	if type(rawData) ~= "table" then return "0_0" end
	return tostring(rawData.level or 1) .. "_" .. tostring(rawData.xp or 0)
end

local function buildSlimeEntry(uniqueId, rawData, fallbackPos)
	local ok, slimeData = pcall(InventoryServiceUtils.getSlimeData, uniqueId, rawData)
	if not ok or not slimeData or not slimeData.id then return nil end

	local stats = computeSlimeStats(uniqueId, rawData)

	return {
		uniqueId          = uniqueId,
		inventoryUniqueId = uniqueId,
		slimeId           = slimeData.id,
		mutations         = slimeData.mutations,
		pos               = fallbackPos or Vector3.new(math.random(-4, 4), 0, math.random(-4, 4)),
		state             = SLIME_STATES.following,
		targetUniqueId    = nil,
		health            = stats.maxHealth,
		maxHealth         = stats.maxHealth,
		speed             = stats.speed  or 30,
		damage            = stats.damage or 10,
		attackRange       = 8,
		attackCooldown    = 1,
		attackTimer       = 0,
	}
end

local function getEquippedSet(equipped)
	local set = {}
	for k, v in pairs(equipped) do
		if type(k) == "number" and type(v) == "string" then set[v] = true
		elseif type(k) == "string" and v == true then set[k] = true end
	end
	return set
end

local function getEquippedIds(equipped)
	local ids, seen = {}, {}
	for k, v in pairs(equipped) do
		local uid
		if type(k) == "number" and type(v) == "string" then uid = v
		elseif type(k) == "string" and v == true then uid = k end
		if uid and not seen[uid] then seen[uid] = true; table.insert(ids, uid) end
	end
	return ids
end

local function buildSlimeMap(data)
	local equipped  = data:get("equipped")  or {}
	local inventory = data:get("inventory") or {}
	local slimeMap  = {}

	local equippedIds = getEquippedIds(equipped)

	for _, uniqueId in ipairs(equippedIds) do
		local entry = buildSlimeEntry(uniqueId, inventory[uniqueId], nil)
		if entry then slimeMap[uniqueId] = entry end
	end

	if next(slimeMap) == nil then
		for uniqueId, rawData in pairs(inventory) do
			local entry = buildSlimeEntry(uniqueId, rawData, Vector3.new(0, 0, 3))
			if entry then
				slimeMap[uniqueId] = entry
				break
			end
		end
	end

	return slimeMap
end

local function slimeToNetwork(s)
	return {
		uniqueId = s.uniqueId, inventoryUniqueId = s.inventoryUniqueId,
		slimeId = s.slimeId, mutations = s.mutations, pos = s.pos,
		state = s.state, targetUniqueId = s.targetUniqueId,
		health = s.health, maxHealth = s.maxHealth, speed = s.speed,
	}
end

local function pushSlimeStats(gameplay, uniqueId, rawData)
	local slime = gameplay.slimeMap[uniqueId]
	if not slime then return end

	local stats  = computeSlimeStats(uniqueId, rawData)
	local newMax = stats.maxHealth or slime.maxHealth

	local newHp
	if slime.health >= slime.maxHealth then
		newHp = newMax
	else
		local ratio = slime.maxHealth > 0 and (slime.health / slime.maxHealth) or 1
		newHp = math.max(math.round(ratio * newMax), 1)
	end

	slime.maxHealth = newMax
	slime.health    = math.min(newHp, newMax)
	slime.damage    = stats.damage or slime.damage
	slime.speed     = stats.speed  or slime.speed

	fireClient(gameplay, "slimeHealthChanged", uniqueId, slime.health, slime.maxHealth)
end

function GameplayService:init()
	remotes031 = networkerModule:WaitForChild("_remotes", 15)
	if not remotes031 then return end

	local svcRemotes = remotes031:WaitForChild("GameplayService", 10)
	if not svcRemotes then return end

	local rf = svcRemotes:FindFirstChild("RemoteFunction")
	if rf then
		rf.OnServerInvoke = function(player, method, ...)
			if method == "getGameplayData" then return self:getGameplayData(player) end
			return nil
		end
	end

	Players.PlayerRemoving:Connect(function(player)
		local g = playerGameplays[player.UserId]
		if g then usedGameplayIds[g.id] = nil end
		playerGameplays[player.UserId] = nil
	end)

	RunService.Heartbeat:Connect(function(dt) self:update(dt) end)
end

function GameplayService:getGameplayData(player)
	if playerGameplays[player.UserId] then
		local g = playerGameplays[player.UserId]
		local slimeList = {}
		for _, s in pairs(g.slimeMap) do table.insert(slimeList, slimeToNetwork(s)) end
		return { id = g.id, slimes = slimeList, enemies = {} }
	end

	local data = DataService:waitForData(player)
	if not data then return nil end

	local gid, re = pickAvailableGameplayId()
	if not gid then return nil end

	usedGameplayIds[gid] = player.UserId

	local inventory  = data:get("inventory") or {}
	local slimeMap   = buildSlimeMap(data)
	local upgrades   = data:get("upgrades")  or {}
	local currentZone = math.max(data:get("zone") or 1, 1)

	local maxEnemies = getMaxEnemies(upgrades)

	local inventorySnapshot = {}
	for uid in pairs(slimeMap) do
		local raw = inventory[uid]
		if raw then inventorySnapshot[uid] = snapshotKey(raw) end
	end

	local gameplay = {
		id                = gid,
		player            = player,
		data              = data,
		slimeMap          = slimeMap,
		enemies           = {},
		remoteEvent       = re,
		enemySpawnTimer   = 2,
		maxEnemies        = maxEnemies,
		currentZone       = currentZone,
		furthestZone      = math.max(data:get("furthestZone") or 1, data:get("maxZone") or 1),
		playerPos         = Vector3.new(0, 0, 0),
		inventorySnapshot = inventorySnapshot,
		mutationCooldowns = {},
	}
	playerGameplays[player.UserId] = gameplay

	local slimeList = {}
	for _, s in pairs(slimeMap) do table.insert(slimeList, slimeToNetwork(s)) end

	return { id = gid, slimes = slimeList, enemies = {} }
end

function GameplayService:spawnEnemy(gameplay)
	local zoneId  = math.max(gameplay.currentZone or 1, 1)
	local enemyId = getEnemyIdForZone(zoneId)
	local upgrades = gameplay.data:get("upgrades") or {}
	local mutations = EnemyMutations.roll(upgrades, gameplay.mutationCooldowns)

	if mutations then
		for mutId, active in pairs(mutations) do
			if active then
				local config = EnemyMutations.getConfig(mutId)
				if config and config.spawnCooldown then
					gameplay.mutationCooldowns[mutId] = (gameplay.mutationCooldowns[mutId] or 0) + config.spawnCooldown
				end
			end
		end
	end

	local stats = getEnemyStats(enemyId, mutations)
	nextEnemyId += 1
	local uid = nextEnemyId

	local angle    = math.random() * math.pi * 2
	local radius   = math.random(18, 28)
	local spawnPos = Vector3.new(
		gameplay.playerPos.X + math.cos(angle) * radius,
		0,
		gameplay.playerPos.Z + math.sin(angle) * radius
	)

	local scale = 1
	if mutations then
		local ok, Mutations = pcall(require, ReplicatedStorage.Source.Features.Mutations.Mutations)
		if ok then scale = Mutations.getSizeScale(mutations) end
	end

	local enemy = {
		uniqueId = uid, enemyId = enemyId, mutations = mutations,
		pos = spawnPos, speed = stats.speed, scale = scale,
		state = ENEMY_STATES.followingPlayer, targetUniqueId = nil,
		health = stats.health, maxHealth = stats.health, damage = stats.damage,
		attackRange = 8, attackCooldown = 1.5, attackTimer = 0,
	}
	gameplay.enemies[uid] = enemy

	fireClient(gameplay, "enemyAdded", {
		uniqueId = uid, enemyId = enemyId, mutations = mutations,
		pos = spawnPos, speed = stats.speed, scale = scale,
		state = ENEMY_STATES.followingPlayer, targetUniqueId = nil,
		health = stats.health, maxHealth = stats.health,
	})
end

function GameplayService:removeEnemy(gameplay, enemy, giveReward)
	if not gameplay.enemies[enemy.uniqueId] then return end
	gameplay.enemies[enemy.uniqueId] = nil
	fireClient(gameplay, "enemyRemoving", enemy.uniqueId)

	if not giveReward then return end

	local info       = Enemies.getEnemyInfo(enemy.enemyId)
	local baseReward = info and info.reward or 50
	local coinMult   = 1
	if enemy.mutations then
		local mods = EnemyMutations.getSpawnModifiers(enemy.mutations)
		coinMult = mods.coinMultiplier or 1
	end

	local zoneScale  = 1 + (gameplay.currentZone - 1) * 0.05
	local coinReward = math.round(baseReward * zoneScale * coinMult)
	local newCoins   = (gameplay.data:get("coins") or 0) + coinReward
	DataService:set(gameplay.player, "coins", newCoins)
	DataService:set(gameplay.player, {"stats","kills"}, (gameplay.data:get({"stats","kills"}) or 0) + 1)

	fireClient(gameplay, "coinRewarded", {
		amount = coinReward, enemyUniqueId = enemy.uniqueId, worldPosition = enemy.pos,
	})

	local upgrades = gameplay.data:get("upgrades") or {}
	if UpgradeServiceUtils.ownsUpgrade("goop", upgrades) then
		local goopDropRate = UpgradeServiceUtils.getGoopDropRate(upgrades)
		if goopDropRate > 0 and math.random() < goopDropRate then
			local goopMult   = EnemyMutations.getGoopRewardMultiplier(enemy.mutations)
			local goopReward = math.max(1, math.round(goopMult))
			local newGoop    = (gameplay.data:get("goop") or 0) + goopReward
			DataService:set(gameplay.player, "goop", newGoop)
			fireClient(gameplay, "goopRewarded", {
				amount = goopReward, enemyUniqueId = enemy.uniqueId, worldPosition = enemy.pos,
			})
		end
	end
end

function GameplayService:update(dt)
	for userId, gameplay in pairs(playerGameplays) do
		local player = gameplay.player
		if not player or not player.Parent then
			usedGameplayIds[gameplay.id] = nil
			playerGameplays[userId] = nil
			continue
		end

		local char = player.Character
		if char then
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if hrp then gameplay.playerPos = Vector3.new(hrp.Position.X, 0, hrp.Position.Z) end
		end

		local newZone = math.max(gameplay.data:get("zone") or 1, 1)
		if newZone ~= gameplay.currentZone then
			gameplay.currentZone = newZone
			for uid in pairs(gameplay.enemies) do
				fireClient(gameplay, "enemyRemoving", uid)
			end
			gameplay.enemies = {}
			gameplay.enemySpawnTimer = 1

			for uid, slime in pairs(gameplay.slimeMap) do
				if slime.state ~= SLIME_STATES.knockedOut then
					slime.state          = SLIME_STATES.following
					slime.targetUniqueId = nil
					slime.attackTimer    = 0
					local angle = math.random() * math.pi * 2
					slime.pos = Vector3.new(
						gameplay.playerPos.X + math.cos(angle) * math.random(3, 7),
						0,
						gameplay.playerPos.Z + math.sin(angle) * math.random(3, 7)
					)
					fireClient(gameplay, "slimeStateChanged", uid, SLIME_STATES.following, nil)
				end
			end
		end

		gameplay.furthestZone = math.max(
			gameplay.data:get("furthestZone") or 1,
			gameplay.data:get("maxZone") or 1
		)

		local upgrades     = gameplay.data:get("upgrades") or {}
		local tutorialData = gameplay.data:get("tutorial")
		local shouldSpawn  = TutorialServiceUtils.shouldSpawnEnemies(tutorialData)

		gameplay.maxEnemies = getMaxEnemies(upgrades)

		for mutId, remaining in pairs(gameplay.mutationCooldowns) do
			local nr = remaining - dt
			if nr <= 0 then gameplay.mutationCooldowns[mutId] = nil
			else gameplay.mutationCooldowns[mutId] = nr end
		end

		local inventory = gameplay.data:get("inventory") or {}
		for uid, slime in pairs(gameplay.slimeMap) do
			local raw = inventory[uid]
			if raw then
				local currentKey = snapshotKey(raw)
				local lastKey    = gameplay.inventorySnapshot[uid]
				if currentKey ~= lastKey then
					gameplay.inventorySnapshot[uid] = currentKey
					pushSlimeStats(gameplay, uid, raw)
				end
			end
		end

		local equipped    = gameplay.data:get("equipped") or {}
		local equippedSet = getEquippedSet(equipped)
		local equippedIds = getEquippedIds(equipped)

		for _, uniqueId in ipairs(equippedIds) do
			if not gameplay.slimeMap[uniqueId] then
				local raw   = inventory[uniqueId]
				local entry = buildSlimeEntry(uniqueId, raw, gameplay.playerPos)
				if entry then
					gameplay.slimeMap[uniqueId]          = entry
					gameplay.inventorySnapshot[uniqueId] = snapshotKey(raw)
					fireClient(gameplay, "slimeAdded", slimeToNetwork(entry))
					fireClient(gameplay, "slimeHealthChanged", uniqueId, entry.health, entry.maxHealth)
				end
			end
		end

		for uniqueId in pairs(gameplay.slimeMap) do
			if not equippedSet[uniqueId] then
				gameplay.slimeMap[uniqueId]          = nil
				gameplay.inventorySnapshot[uniqueId] = nil
				fireClient(gameplay, "slimeRemoving", uniqueId)
			end
		end

		local liveEnemyCount = 0
		for _ in pairs(gameplay.enemies) do liveEnemyCount += 1 end

		
		local inCombat = anySlimeInCombat(gameplay)

		if shouldSpawn and liveEnemyCount < gameplay.maxEnemies then
			gameplay.enemySpawnTimer -= dt
			if gameplay.enemySpawnTimer <= 0 then
				gameplay.enemySpawnTimer = 2.5
				self:spawnEnemy(gameplay)
			end
		elseif inCombat and liveEnemyCount >= gameplay.maxEnemies then
			gameplay.enemySpawnTimer = 2.5
		end

		for uid, enemy in pairs(gameplay.enemies) do
			local closestSlime, closestDist = nil, math.huge
			for _, slime in pairs(gameplay.slimeMap) do
				if slime.state ~= SLIME_STATES.knockedOut then
					local d = (enemy.pos - slime.pos).Magnitude
					if d < closestDist then closestDist = d; closestSlime = slime end
				end
			end

			local newState, newTarget = ENEMY_STATES.followingPlayer, nil
			if closestSlime and closestDist < 80 then
				newTarget = closestSlime.uniqueId
				if closestDist <= enemy.attackRange then
					newState = ENEMY_STATES.attacking
				else
					newState = ENEMY_STATES.targetingSlime
					local dir = closestSlime.pos - enemy.pos
					if dir.Magnitude > 0.01 then
						enemy.pos += dir.Unit * math.min(enemy.speed * dt, dir.Magnitude)
					end
				end
			else
				local dir = gameplay.playerPos - enemy.pos
				if dir.Magnitude > 8 then enemy.pos += dir.Unit * enemy.speed * dt end
			end

			if newState ~= enemy.state or newTarget ~= enemy.targetUniqueId then
				enemy.state = newState; enemy.targetUniqueId = newTarget
				fireClient(gameplay, "enemyStateChanged", uid, newState, newTarget)
			end

			if enemy.state == ENEMY_STATES.attacking and closestSlime then
				enemy.attackTimer -= dt
				if enemy.attackTimer <= 0 then
					enemy.attackTimer = enemy.attackCooldown
					local slime = gameplay.slimeMap[closestSlime.uniqueId]
					if slime and slime.state ~= SLIME_STATES.knockedOut then
						slime.health = math.max(slime.health - enemy.damage, 0)
						fireClient(gameplay, "enemyAttack", uid, slime.uniqueId, enemy.damage)
						fireClient(gameplay, "slimeHealthChanged", slime.uniqueId, slime.health, slime.maxHealth)
						if slime.health <= 0 then
							slime.state = SLIME_STATES.knockedOut
							fireClient(gameplay, "slimeStateChanged", slime.uniqueId, SLIME_STATES.knockedOut, nil)
							local sid = slime.uniqueId
							task.delay(6, function()
								local g = playerGameplays[userId]
								if not g or not g.slimeMap[sid] then return end
								local s = g.slimeMap[sid]
								s.health = s.maxHealth
								s.state = SLIME_STATES.following
								s.targetUniqueId = nil
								s.attackTimer = 0
								fireClient(g, "slimeHealthChanged", sid, s.health, s.maxHealth)
								fireClient(g, "slimeStateChanged", sid, SLIME_STATES.following, nil)
							end)
						end
					end
				end
			end
		end

		for uid, slime in pairs(gameplay.slimeMap) do
			if slime.state == SLIME_STATES.knockedOut then continue end

			local closestEnemy, closestDist = nil, math.huge
			for _, enemy in pairs(gameplay.enemies) do
				local d = (slime.pos - enemy.pos).Magnitude
				if d < closestDist then closestDist = d; closestEnemy = enemy end
			end

			local newState, newTarget = SLIME_STATES.following, nil
			if closestEnemy and closestDist < 55 then
				newTarget = closestEnemy.uniqueId
				if closestDist <= slime.attackRange then
					newState = SLIME_STATES.attacking
				else
					newState = SLIME_STATES.targeting
					local dir = closestEnemy.pos - slime.pos
					if dir.Magnitude > slime.attackRange then
						slime.pos += dir.Unit * math.min(slime.speed * dt, dir.Magnitude - slime.attackRange)
					end
				end
			else
				local dir = gameplay.playerPos - slime.pos
				if dir.Magnitude > 10 then
					slime.pos += dir.Unit * math.min(slime.speed * dt, dir.Magnitude - 8)
				end
			end

			if newState ~= slime.state or newTarget ~= slime.targetUniqueId then
				slime.state = newState; slime.targetUniqueId = newTarget
				fireClient(gameplay, "slimeStateChanged", uid, newState, newTarget)
			end

			if slime.state == SLIME_STATES.attacking and closestEnemy then
				slime.attackTimer -= dt
				if slime.attackTimer <= 0 then
					slime.attackTimer = slime.attackCooldown
					local enemy = gameplay.enemies[closestEnemy.uniqueId]
					if enemy then
						enemy.health = math.max(enemy.health - slime.damage, 0)
						fireClient(gameplay, "slimeAttack", uid, closestEnemy.uniqueId, slime.damage)
						fireClient(gameplay, "enemyHealthChanged", closestEnemy.uniqueId, enemy.health, enemy.maxHealth)
						if enemy.health <= 0 then self:removeEnemy(gameplay, enemy, true) end
					end
				end
			end
		end
	end
end

return GameplayService