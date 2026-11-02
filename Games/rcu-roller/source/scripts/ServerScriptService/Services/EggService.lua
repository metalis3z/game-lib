--[[
	EggService — Egg opening and pet hatching for the pet simulator.
	Handles:
	  - Client RemoteFunction: openEgg (player requests to hatch eggs)
	  - Client RemoteSignal: openEgg (server fires hatched pet data back)
	  - Client RemoteProperty: globalLuckyEggs, globalLuckEventAmount
	  - Server method: getGlobalLuckEventAmount() (called by Values.Luck)
]]
local HttpService    = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

-- Config tables
local EggsConfig = require(ReplicatedStorage.Shared.List.Pets.Eggs)
local PetsConfig  = require(ReplicatedStorage.Shared.List.Pets.Pets)
local TiersList   = require(ReplicatedStorage.Shared.List.Pets.Tiers)

-- Values modules (full luck calculation including upgrades, potions, events, passes)
local ValLuck        = require(ReplicatedStorage.Shared.Values.Luck)
local ValGoldenLuck  = require(ReplicatedStorage.Shared.Values.GoldenPetsLuck)
local ValToxicLuck   = require(ReplicatedStorage.Shared.Values.ToxicPetsLuck)

-- Tier index constants (Tiers is an ordered array)
-- [1] = Normal, [2] = Golden, [3] = Toxic
local TIER_NORMAL = 1
local TIER_GOLDEN = 2
local TIER_TOXIC  = 3

-- Base chances for non-Normal tiers (these are the "1 in N" odds)
-- Golden: 1% base = roll <= 1.0
-- Toxic:  0.1% base = roll <= 0.1
-- These are applied as percentage chances from 0-100 roll
local GOLDEN_CHANCE = 1.0   -- 1%
local TOXIC_CHANCE  = 0.1   -- 0.1%
-- Rate-limit: max eggs per request
local MAX_EGGS_PER_REQUEST = 100

-- Rarities that should NOT stack (Supreme and above)
local NON_STACKABLE_RARITIES = {
	Supreme = true,
	Ultimate = true,
	Secret = true,
}

------------------------------------------------------------------------
-- Find existing stackable pet in inventory (same name + tier, not shiny)
------------------------------------------------------------------------
local function findStackablePet(petInventory, petName, tierIndex)
	if not petInventory then return nil end
	for id, entry in petInventory do
		if type(entry) == "table"
			and entry.nm == petName
			and (entry.ti or 1) == tierIndex
			and not entry.sh
		then
			return id, entry
		end
	end
	return nil
end

------------------------------------------------------------------------
-- EggService
------------------------------------------------------------------------
local EggService = Knit.CreateService({
	Name = "EggService",
	Client = {
		-- Signal: server fires to client with { pets = { petData, ... } }
		openEgg = Knit.CreateSignal(),

		-- Signal: client fires to toggle auto-hatching
		setIsAutoHatching = Knit.CreateSignal(),

		-- Exclusive egg animation signals (client-to-client via server relay)
		openExclusiveEgg = Knit.CreateSignal(),
		spawnHammer       = Knit.CreateSignal(),
		hitHammer         = Knit.CreateSignal(),
		despawnHammer     = Knit.CreateSignal(),

		-- Global lucky eggs state (table of egg names that have bonus)
		globalLuckyEggs = Knit.CreateProperty({}),

		-- Global luck event multiplier (additive bonus on top of base luck)
		globalLuckEventAmount = Knit.CreateProperty(0),
	},

	-- Internal services (set in KnitInit)
	_DataService = nil,
	_InventoryService = nil,
	_lastOpenTime = nil, -- per-player rate-limit table (player → tick())
})

------------------------------------------------------------------------
-- Helpers
------------------------------------------------------------------------
-- Weighted random roll over an egg's pets table with luck scaling.
-- petsTable: { [petName] = chance, ... } (raw from EggsConfig)
-- luck: multiplier from Values.Luck (base 1.0). Higher luck = rarer pets more likely.
--   Formula: effectiveWeight = baseWeight ^ (1 / luck)
--   This compresses the weight spread, making rare pets relatively more probable.
-- Returns: petName string
local function rollPet(petsTable, luck)
	luck = math.max(luck or 1, 1) -- clamp to minimum 1

	local total = 0
	local adjusted = {}
	for petName, chance in petsTable do
		local w = chance ^ (1 / luck)
		adjusted[petName] = w
		total += w
	end

	local roll = math.random() * total
	local accumulated = 0
	local lastPet = nil
	for petName, w in adjusted do
		accumulated += w
		lastPet = petName
		if roll <= accumulated then
			return petName
		end
	end

	return lastPet
end

-- Roll tier for a single hatch.
-- goldenBonus: additive percentage bonus on golden chance (from upgrades/potions)
-- toxicBonus:  additive percentage bonus on toxic chance
-- Returns: tier name string ("Normal", "Golden", "Toxic")
local function rollTier(goldenBonus, toxicBonus)
	local toxicThreshold  = TOXIC_CHANCE  + (toxicBonus  or 0)
	local goldenThreshold = GOLDEN_CHANCE + (goldenBonus or 0)

	local roll = math.random() * 100 -- 0..100

	if roll <= toxicThreshold then
		return TIER_TOXIC
	elseif roll <= goldenThreshold then
		return TIER_GOLDEN
	else
		return TIER_NORMAL
	end
end
-- Get the player's golden/toxic luck bonuses using the full Values modules.
-- This includes upgrades, potions, active events, AND gamepass bonuses.
local function getPlayerTierBonuses(player, data)
	local goldenBonus = ValGoldenLuck(player, data)
	local toxicBonus  = ValToxicLuck(player, data)
	return goldenBonus, toxicBonus
end

------------------------------------------------------------------------
-- Core hatch logic (internal)
------------------------------------------------------------------------
function EggService:_handleOpenEgg(player, eggName, amount)
	-- 0. Per-player rate limit (0.5 s cooldown)
	local now = tick()
	if now - (self._lastOpenTime[player] or 0) < 0.5 then
		return false
	end
	self._lastOpenTime[player] = now
	-- 1. Validate egg name
	local eggConfig = EggsConfig[eggName]
	if not eggConfig then
		warn("[EggService] Unknown egg:", eggName, "from", player.Name)
		return false
	end

	-- 2. Clamp amount
	amount = math.clamp(math.floor(tonumber(amount) or 1), 1, MAX_EGGS_PER_REQUEST)

	-- 3. Wait for data to be loaded
	local data = self._DataService:WaitForData(player)
	if not data then
		warn("[EggService] No data for", player.Name)
		return false
	end

	-- 4. Check currency (eggs use "clicks" unless egg config specifies otherwise)
	local currencyKey = eggConfig.currency or "clicks"
	local totalCost   = eggConfig.cost * amount
	local balance     = data[currencyKey] or 0

	if balance < totalCost then
		return false
	end

	-- 5. Optional canHatch check (e.g. Hacker egg requires 6 light switches)
	if eggConfig.canHatch and not eggConfig.canHatch(data) then
		return false
	end

	-- 6. Deduct currency via replica
	local replica = self._DataService:GetReplica(player)
	if not replica then
		warn("[EggService] No replica for", player.Name)
		return false
	end

	local newBalance = balance - totalCost
	replica:Set({ currencyKey }, newBalance)

	-- 7. Get tier bonuses and luck for this player
	local goldenBonus, toxicBonus = getPlayerTierBonuses(player, data)
	local luck = ValLuck(player, data)

	-- 8. Hatch each egg
	local hatchedPets = {}

	for _ = 1, amount do
		-- a. Roll pet name (weighted random, scaled by luck)
		local petName = rollPet(eggConfig.pets, luck)

		-- b. Get pet config
		local petConfig = PetsConfig[petName]
		if not petConfig then
			-- Fallback: skip this pet (config mismatch)
			warn("[EggService] Pet config missing for:", petName)
			continue
		end

		-- c. Roll tier (returns 1=Normal, 2=Golden, 3=Toxic)
		local tierIndex = rollTier(goldenBonus, toxicBonus)

		-- d. Check if this pet can stack (not Supreme/Ultimate/Secret)
		local canStack = not NON_STACKABLE_RARITIES[petConfig.rarity]
		local stacked = false

		if canStack then
			-- Try to find existing matching pet in inventory to stack
			local existingId = findStackablePet(data.inventory.pet, petName, tierIndex)
			if existingId then
				local currentAm = data.inventory.pet[existingId].am or 1
				replica:Set({ "inventory", "pet", existingId, "am" }, currentAm + 1)
				stacked = true
			end
		end

		if not stacked then
			-- Create new entry with unique ID
			local uuid = HttpService:GenerateGUID(false)
			local petData = {
				cl          = "pet",
				nm          = petName,
				ti          = tierIndex,
				uuid        = uuid,
				lk          = false,
				createdAt   = os.time(),
			}
			replica:Set({ "inventory", "pet", uuid }, petData)
		end

		-- e. Update index (unique pets discovered)
		local descriptor = petName:gsub(" ", ""):lower() .. ":" .. tostring(tierIndex)
		if not data.index[descriptor] then
			replica:Set({ "index", descriptor }, true)
		end

		-- f. Add to hatched list for client display
		table.insert(hatchedPets, {
			cl = "pet",
			nm = petName,
			ti = tierIndex,
		})
	end

	-- g. Update totalEggsOpened stat
	local newTotal = (data.stats.totalEggsOpened or 0) + amount
	replica:Set({ "stats", "totalEggsOpened" }, newTotal)
	local newEggsOpened = (data.stats.eggsOpened or 0) + amount
	replica:Set({ "stats", "eggsOpened" }, newEggsOpened)

	-- Quest hooks: openEgg + hatchPet
	local QuestService = Knit.GetService("QuestService")
	QuestService:IncrementQuest(player, "openEgg", amount, eggName)
	for _, pet in hatchedPets do
		QuestService:IncrementQuest(player, "hatchPet", 1, pet.nm)
	end
	-- 9. Fire signal to client with hatched pets
	self.Client.openEgg:Fire(player, eggName, hatchedPets, amount)

	return true
end

-- NOTE: openEgg is a Signal (not a RemoteFunction). The client calls :Fire(eggName, amount)
-- and we listen for it in KnitInit. We fire results back on the same signal.

------------------------------------------------------------------------
-- Server-accessible method called by Values.Luck on the server
------------------------------------------------------------------------
function EggService:getGlobalLuckEventAmount()
	return self.Client.globalLuckEventAmount:Get()
end

------------------------------------------------------------------------
-- Global state setters (for admin commands / event systems)
------------------------------------------------------------------------

-- Set the global luck event amount (additive bonus passed to luck calc)
function EggService:setGlobalLuckEventAmount(amount)
	self.Client.globalLuckEventAmount:Set(amount)
end

-- Set the global lucky eggs table (e.g. { Basic = true, Forest = true })
function EggService:setGlobalLuckyEggs(t)
	self.Client.globalLuckyEggs:Set(t)
end

------------------------------------------------------------------------
-- Knit lifecycle
------------------------------------------------------------------------
function EggService:KnitInit()
	self._DataService = Knit.GetService("DataService")
	self._InventoryService = Knit.GetService("InventoryService")
	self._lastOpenTime = {} -- player → tick() of last accepted open request

	-- Clean up rate-limit entry when player leaves
	game:GetService("Players").PlayerRemoving:Connect(function(player)
		self._lastOpenTime[player] = nil
	end)

	-- Listen for client openEgg signal (client fires eggName, amount)
	self.Client.openEgg:Connect(function(player, eggName, amount)
		self:_handleOpenEgg(player, eggName, amount)
	end)

	-- Listen for auto-hatching toggle
	self.Client.setIsAutoHatching:Connect(function(player, eggName)
		-- Auto-hatch state is purely client-side; server just acknowledges
	end)
end

-- Client RemoteFunction: autoArchive — unequip pet from hatching
function EggService.Client:autoArchive(player, petUid)
	if not petUid or type(petUid) ~= "string" then return end
	local PetService = Knit.GetService("PetService")
	if PetService and PetService.Client.archivePet then
		-- Delegate to PetService's archive logic
		PetService.Client:archivePet(player, petUid)
	end
end

function EggService:KnitStart()
	print("[EggService] Started")

	-- Handle exclusive egg opening: client fires openExclusiveEgg(itemId, amount)
	-- itemId is the inventory GUID (key in data.inventory.exclusiveEgg)
	self.Client.openExclusiveEgg:Connect(function(player, itemId, amount)
		local ExclusiveEggs = require(ReplicatedStorage.Shared.List.Items.ExclusiveEggs)

		amount = math.clamp(math.floor(tonumber(amount) or 1), 1, 10)

		local data = self._DataService:WaitForData(player)
		if not data then return end

		-- itemId is the GUID key in inventory.exclusiveEgg
		-- each entry: {cl='exclusiveEgg', nm='stormExclusiveEgg', am=N}
		local invExcEggs = data.inventory and data.inventory.exclusiveEgg
		if not invExcEggs then
			warn("[EggService] No exclusiveEgg inventory for", player.Name)
			return
		end

		local entry = invExcEggs[itemId]
		if not entry then
			warn("[EggService] exclusiveEgg item not found:", itemId, "for", player.Name)
			return
		end

		local eggName = entry.nm
		local owned = entry.am or 1

		local eggConfig = ExclusiveEggs[eggName]
		if not eggConfig then
			warn("[EggService] Unknown exclusive egg config:", eggName)
			return
		end

		if owned < amount then
			warn("[EggService] Not enough exclusive eggs:", owned, "<", amount, "for", player.Name)
			return
		end

		-- Deduct eggs via InventoryService
		self._InventoryService:RemoveItem(player, 'exclusiveEgg', eggName, amount)

		-- Roll pets
		local hatchedPets = {}
		for _ = 1, amount do
			local petId = rollPet(eggConfig.pets)
			if petId then
				self._InventoryService:GiveItem(player, {category='pet', id=petId, amount=1})
				table.insert(hatchedPets, {cl='pet', nm=petId, am=1})
			end
		end

		-- Fire back to client for exclusive egg animation (ExclusiveEggController handles this)
		-- openExclusiveEgg signal goes to ExclusiveEggController, NOT HatchingController
		self.Client.openEgg:Fire(player, eggConfig.name, hatchedPets, amount)
		print("[EggService]", player.Name, "opened", amount, "x", eggName, "->", #hatchedPets, "pets")
	end)
end

return EggService
