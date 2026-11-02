local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataService = require(ReplicatedStorage.Packages.DataService).server
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local MonetizationServiceUtils = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceUtils)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)

local RollService = {}
RollService.__index = RollService

local _adminLuckService = nil
local function getAdminLuckService()
	if _adminLuckService then return _adminLuckService end
	local ok, svc = pcall(function()
		local services = ServerScriptService:FindFirstChild("Services")
		local mod = services and services:FindFirstChild("AdminLuckService")
		return mod and require(mod)
	end)
	if ok and svc then _adminLuckService = svc end
	return _adminLuckService
end

local function getAdminLuckState()
	local als = getAdminLuckService()
	if not als then return nil end
	local ok, state = pcall(function() return als:getState() end)
	if not ok or not state then return nil end
	local now = math.floor(workspace:GetServerTimeNow())
	if state.multiplier > 1 and state.expirationTime > 0 and now < state.expirationTime then
		return state
	end
	return nil
end

local function getMaxWeightForMultiplier(multiplier: number): number
	if multiplier >= 50 then
		return 9999
	elseif multiplier >= 25 then
		return 99999
	elseif multiplier >= 10 then
		return 999999
	elseif multiplier >= 5 then
		return 9999999
	elseif multiplier >= 2 then
		return 99999999
	end
	return math.huge
end

local TIER_AMPLIFIERS = {
	{ minWeight = 100000000, amplifier = 1  },
	{ minWeight = 10000000,  amplifier = 3  },
	{ minWeight = 1000000,   amplifier = 8  },
	{ minWeight = 100000,    amplifier = 14 },
	{ minWeight = 10000,     amplifier = 18 },
	{ minWeight = 0,         amplifier = 22 },
}

local function getTierAmplifier(rawWeight: number): number
	for _, tier in ipairs(TIER_AMPLIFIERS) do
		if rawWeight >= tier.minWeight then return tier.amplifier end
	end
	return 22
end

-- ─── Mutation Chances ─────────────────────────────────────────────────────────
local MUTATION_CHANCES = {
	huge     = 0.008,
	big      = 0.055,
	shiny    = 0.030,
	inverted = 0.012,
}

local function getMutationLuckMultiplier(zone: number): number
	return 1 + math.log(math.max(zone, 1)) * 0.25
end

local function buildSlimePool(playerZone: number, maxWeight: number?, ignoreMinZone: boolean?)
	local pool = {}
	local filter = maxWeight or math.huge
	for _, slimeInfo in ipairs(Slimes.getSortedSlimes()) do
		local rawWeight = slimeInfo.weight or 0
		if rawWeight > 0 and not slimeInfo.craftable then
			local zoneOk = ignoreMinZone or (playerZone >= (slimeInfo.minZone or 0))
			if zoneOk and rawWeight <= filter then
				table.insert(pool, {
					id     = slimeInfo.id,
					weight = rawWeight * getTierAmplifier(rawWeight),
				})
			end
		end
	end
	return pool
end

local function pickWeightedSlime(pool)
	if #pool == 0 then return "goopy" end
	local total = 0
	for _, e in ipairs(pool) do total += e.weight end
	local r = math.random() * total
	local cum = 0
	for _, e in ipairs(pool) do
		cum += e.weight
		if r <= cum then return e.id end
	end
	return pool[#pool].id
end

local function rollMutations(zone: number, upgrades, adminMult: number?)
	local mult = getMutationLuckMultiplier(zone)
	if adminMult and adminMult > 1 then
		mult = mult * math.min(adminMult * 0.5, 5)
	end
	local unlocked = UpgradeServiceUtils.getUnlockedMutations(upgrades)
	local result = {}
	local has = false

	if unlocked.huge and math.random() < MUTATION_CHANCES.huge * mult then
		result.huge = true; has = true
	elseif unlocked.big and math.random() < MUTATION_CHANCES.big * mult then
		result.big = true; has = true
	end
	if unlocked.shiny and math.random() < MUTATION_CHANCES.shiny * mult then
		result.shiny = true; has = true
	end
	if unlocked.inverted and math.random() < MUTATION_CHANCES.inverted * mult then
		result.inverted = true; has = true
	end

	return has and result or nil
end

local function hasGamepass(data, productKey)
	local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
	local product = Products[productKey]
	if not product or not product.id then return false end
	local gp = data:get("__gamepasses") or {}
	return gp[tostring(product.id)] == true
end

local function countEquipped(equipped)
	if type(equipped) ~= "table" then return 0 end
	local n = 0
	for k, v in pairs(equipped) do
		if (type(k) == "number" and type(v) == "string") or
			(type(k) == "string" and v == true) then
			n += 1
		end
	end
	return n
end

local function rollOnce(pool, zone, upgrades, adminMult)
	local pickedId  = pickWeightedSlime(pool)
	local mutations = rollMutations(zone, upgrades, adminMult)
	return {
		id        = pickedId,
		level     = 1,
		xp        = 0,
		mutations = mutations,
	}
end

function RollService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then warn("[RollService] _remotes not found"); return end

	local rollRemotes = remotes:WaitForChild("RollService", 10)
	if not rollRemotes then warn("[RollService] RollService remotes not found"); return end

	local rf = rollRemotes:FindFirstChild("RemoteFunction")
	local re = rollRemotes:FindFirstChild("RemoteEvent")

	if rf then
		rf.OnServerInvoke = function(player, method, ...)
			if method == "requestRoll" then
				return self:requestRoll(player)
			elseif method == "requestSetSpecialRollPaused" then
				return self:requestSetSpecialRollPaused(player, ...)
			end
			warn("[RollService] Unknown method:", method)
			return false
		end
		print("[RollService] OnServerInvoke set")
	end

	if re then
		re.OnServerEvent:Connect(function(player, method, ...)
			if method == "requestSetSpecialRollPaused" then
				self:requestSetSpecialRollPaused(player, ...)
			end
		end)
	end

	print("[RollService] Initialized")
end

function RollService:requestRoll(player: Player)
	local data = DataService:waitForData(player)
	if not data then
		warn("[RollService] No data for", player.Name)
		return false, nil, nil, nil
	end

	local upgrades     = data:get("upgrades") or {}
	local furthestZone = math.max(data:get("furthestZone") or 1, data:get("maxZone") or 1)
	local currentZone  = math.max(data:get("zone") or 1, 1)
	local effectiveZone = math.max(currentZone, furthestZone)

	-- ── Upgrade-based luck ────────────────────────────────────────────────
	local luckLevel = UpgradeServiceUtils.getUpgradeLevel("luck", upgrades)
	local luckValue = UpgradeServiceUtils.getUpgradeValue("luck", luckLevel)

	-- ── Admin luck ────────────────────────────────────────────────────────
	local adminState = getAdminLuckState()
	local adminMult  = adminState and adminState.multiplier or 1

	if adminMult > 1 then
		luckValue = luckValue * adminMult
		print(string.format(
			"[RollService] Admin luck ACTIVE x%s | luckValue: %s | player: %s",
			adminMult, luckValue, player.Name
			))
	end

	-- ── Build pool ────────────────────────────────────────────────────────
	local maxWeight     = adminMult > 1 and getMaxWeightForMultiplier(adminMult) or nil
	local ignoreMinZone = adminMult > 1  -- bypass minZone gate when admin luck is active
	local luckZoneBoost = math.floor((luckValue - 1) * 2)

	local pool = buildSlimePool(effectiveZone, maxWeight, ignoreMinZone)

	if #pool == 0 then
		warn("[RollService] Admin luck pool empty for zone", effectiveZone, "- falling back to full pool")
		pool = buildSlimePool(effectiveZone, nil, false)
	end

	if luckZoneBoost > 0 then
		local boostedPool = buildSlimePool(effectiveZone + luckZoneBoost, maxWeight, ignoreMinZone)
		if #boostedPool > 0 and #boostedPool > #pool then
			pool = boostedPool
		end
	end

	if adminMult > 1 then
		print(string.format(
			"[RollService] Admin pool size: %d slimes | maxWeight filter: %s | zone: %d | player: %s",
			#pool, tostring(maxWeight), effectiveZone, player.Name
			))
	end

	local function ownsPass(productKey)
		return hasGamepass(data, productKey)
	end

	local columns = MonetizationServiceUtils.getRollColumns(ownsPass)

	local rolledSlimes  = {}
	local rollResults   = {}
	local newSlimeQueue = {}

	local inventory    = data:get("inventory") or {}
	local newInventory = table.clone(inventory)
	local equipped     = data:get("equipped")  or {}
	local newEquipped  = table.clone(equipped)
	local maxSlots     = InventoryServiceUtils.getOwnedSlotCount(upgrades)
	local usedSlots    = countEquipped(newEquipped)

	for i = 1, columns do
		local slimeData = rollOnce(pool, effectiveZone, upgrades, adminMult)
		local uniqueKey = InventoryServiceUtils.genKey(slimeData)

		newInventory[uniqueKey] = slimeData

		if usedSlots < maxSlots then
			usedSlots += 1
			newEquipped[usedSlots] = uniqueKey
			print("[RollService] Auto-equipped col", i, slimeData.id, "slot", usedSlots)
		end

		table.insert(rolledSlimes, slimeData)
		table.insert(rollResults, slimeData)
		table.insert(newSlimeQueue, {
			uniqueId  = uniqueKey,
			id        = slimeData.id,
			mutations = slimeData.mutations,
			level     = 1,
			xp        = 0,
		})

		local rawWeight = 0
		for _, s in ipairs(Slimes.getSortedSlimes()) do
			if s.id == slimeData.id then rawWeight = s.weight or 0; break end
		end
		local mutStr = "none"
		if slimeData.mutations then
			local parts = {}
			for k, v in pairs(slimeData.mutations) do if v then parts[#parts+1] = k end end
			mutStr = table.concat(parts, "+")
		end
		print(string.format(
			"[RollService] Col %d: %s (w=%d) | mut: %s | zone: %d | player: %s",
			i, slimeData.id, rawWeight, mutStr, effectiveZone, player.Name
			))
	end

	DataService:set(player, "inventory", newInventory)
	DataService:set(player, "equipped",  newEquipped)

	for _, slimeData in ipairs(rolledSlimes) do
		local ok, err = pcall(function()
			local rawIndex  = data:get("index")
			local indexData = IndexServiceUtils.cloneIndexData(
				IndexServiceUtils.reconcileIndexData(rawIndex)
			)
			IndexServiceUtils.trackSlimeData(indexData, slimeData, 1)
			DataService:set(player, "index", indexData)
		end)
		if not ok then warn("[RollService] Index update failed:", err) end
	end

	local stats = data:get("stats") or {}
	DataService:set(player, { "stats", "rolls" }, (stats.rolls or 0) + 1)

	-- Special roll progression
	local specialRollProgression = data:get("specialRollProgression") or {
		golden  = { rollsUntilNext = 10,   paused = false },
		diamond = { rollsUntilNext = 100,  paused = false },
		void    = { rollsUntilNext = 1000, paused = false },
	}

	local activeSpecialRolls = {}
	for kind, prog in pairs(specialRollProgression) do
		if (prog.rollsUntilNext or 1) <= 0 and not prog.paused then
			activeSpecialRolls[kind] = true
		end
	end

	local newProgression = {}
	for kind, prog in pairs(specialRollProgression) do
		local defaultReset = kind == "golden" and 10 or kind == "diamond" and 100 or 1000
		newProgression[kind] = {
			rollsUntilNext = activeSpecialRolls[kind] and defaultReset
				or math.max((prog.rollsUntilNext or 1) - 1, 0),
			paused = prog.paused,
		}
	end
	DataService:set(player, "specialRollProgression", newProgression)

	local rollTable = {
		luck                = luckValue * math.max(effectiveZone, 1),
		maxLuck             = luckValue * math.max(effectiveZone, 1),
		luckOverridden      = adminMult > 1,
		rolls               = 1,
		columns             = columns,
		extraRollChance     = 0,
		jackpotChance       = 0.001,
		luckRollChance      = 0.18,
		rollTime            = 3,
		rollSpeedMultiplier = 1,
		activeSpecialRolls  = activeSpecialRolls,
		forcedMutationId    = nil,
	}

	local wrappedResults = {}
	for _, s in ipairs(rolledSlimes) do
		table.insert(wrappedResults, { s })
	end

	return wrappedResults, rollTable, newSlimeQueue, {}
end

function RollService:requestSetSpecialRollPaused(player: Player, rollKind: string, paused: boolean)
	if type(rollKind) ~= "string" or type(paused) ~= "boolean" then return false end
	local data = DataService:waitForData(player)
	if not data then return false end
	DataService:set(player, { "specialRollProgression", rollKind, "paused" }, paused)
	return true
end

return RollService