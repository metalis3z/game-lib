-- Game: brainrot-lab
-- Original: ServerScriptService/Modules/BrainrotConveyor.lua
-- Excerpt of lines 36-71, 139-198, 1079-1132
-- What it does: Conveyor spawner where Legendary / Mythical / Secret never roll randomly; instead a countdown per rarity guarantees one when it hits zero, with a world sign showing the time left.
-- ===== Excerpt of lines 36-71 of ServerScriptService/Modules/BrainrotConveyor.lua =====

-- [ CONFIGURATION ]
local SPAWN_INTERVAL = 3        -- seconds between spawns
local TRAVEL_TIME = 50         -- seconds from A to B
local MAX_ACTIVE_BRAINROTS = 20  -- safety cap
local EVENT_MUTATION_CHANCE = 1.0  -- probability a spawned brainrot inherits the active event's mutation

-- Rarity spawn weights (using existing 6 rarities)
local RARITY_WEIGHTS = {
	Common = 50,
	Uncommon = 25,
	Rare = 15,
	Epic = 10,
	-- Legendary and Secret are ONLY spawned via pity timer, never randomly
}

local RARITY_ORDER = {"Common", "Uncommon", "Rare", "Epic"}

-- Pity timer configuration (seconds until guaranteed spawn)
local LEGENDARY_PITY_TIME = 600   -- 10 minutes
local SECRET_PITY_TIME = 3600  -- 2 hours
local MYTHICAL_PITY_TIME = 1800  -- 30 minutes

-- [ STATE ]
local BrainrotConveyor = {}
local activeBrainrots = {}  -- array of {model = Model, claimed = boolean}
local isRunning = false
local PICKUP_RANGE = 10  -- studs - max distance to pick up with E

-- Forced next spawn (set by the admin panel): { itemName, mutation, rarity }
local forcedBrainrot = nil

-- Pity timer state
local pityLegendaryTimer = LEGENDARY_PITY_TIME
local pitySecretTimer = SECRET_PITY_TIME
local pityMythicalTimer = MYTHICAL_PITY_TIME

-- ===== Excerpt of lines 139-198 of ServerScriptService/Modules/BrainrotConveyor.lua =====

local function selectRandomItem()
	-- Check pity timers first (Secret takes priority over Legendary)
	if secretPityActive then
		secretPityActive = false
		pitySecretTimer = SECRET_PITY_TIME
		local items = ItemConfigurations.GetItemsByRarity("Secret")
		if items and #items > 0 then
			return items[math.random(1, #items)], "Secret"
		end
	end

	if mythicalPityActive then
		mythicalPityActive = false
		pityMythicalTimer = MYTHICAL_PITY_TIME
		local items = ItemConfigurations.GetItemsByRarity("Mythical")
		if items and #items > 0 then
			return items[math.random(1, #items)], "Mythical"
		end
	end

	if legendaryPityActive then
		legendaryPityActive = false
		pityLegendaryTimer = LEGENDARY_PITY_TIME
		local items = ItemConfigurations.GetItemsByRarity("Legendary")
		if items and #items > 0 then
			return items[math.random(1, #items)], "Legendary"
		end
	end

	-- Weighted random selection by rarity
	local totalWeight = 0
	for _, rarity in ipairs(RARITY_ORDER) do
		totalWeight += RARITY_WEIGHTS[rarity] or 0
	end

	local roll = math.random() * totalWeight
	local accumulated = 0
	local selectedRarity = "Common"

	for _, rarity in ipairs(RARITY_ORDER) do
		accumulated += RARITY_WEIGHTS[rarity] or 0
		if roll <= accumulated then
			selectedRarity = rarity
		break
		end
	end

	-- Get all items of this rarity
	local items = ItemConfigurations.GetItemsByRarity(selectedRarity)
	if not items or #items == 0 then
		-- Fallback to Common
		items = ItemConfigurations.GetItemsByRarity("Common")
		selectedRarity = "Common"
	end

	if not items or #items == 0 then return nil, nil end

	local itemName = items[math.random(1, #items)]
	return itemName, selectedRarity

-- ===== Excerpt of lines 1079-1132 of ServerScriptService/Modules/BrainrotConveyor.lua =====
	-- Pity timer countdown loop
	local legendarySound, secretSound, mythicalSound = getPitySounds()

	task.spawn(function()
		while isRunning do
			if not legendaryPityActive then
				pityLegendaryTimer = math.max(0, pityLegendaryTimer - 1)
				if pityLegendaryTimer <= 0 then
					legendaryPityActive = true
					playPityAlertSound(legendarySound)
				end
			end
			if not secretPityActive then
				pitySecretTimer = math.max(0, pitySecretTimer - 1)
				if pitySecretTimer <= 0 then
					secretPityActive = true
					playPityAlertSound(secretSound)
				end
			end
			if not mythicalPityActive then
				pityMythicalTimer = math.max(0, pityMythicalTimer - 1)
				if pityMythicalTimer <= 0 then
					mythicalPityActive = true
					playPityAlertSound(mythicalSound)
				end
			end

			-- Update UI
			getCountdownUI()
			if lblLegendary then
				if legendaryPityActive then
					lblLegendary.Text = 'Guaranteed <font color="#FFCC00">Legendary</font> spawning now!'
				else
					lblLegendary.Text = 'Guaranteed <font color="#FFCC00">Legendary</font> in ' .. formatTime(pityLegendaryTimer)
				end
			end
			if lblSecret then
				if secretPityActive then
					lblSecret.Text = 'Guaranteed <font color="#FFFFFF">Secret</font> spawning now!'
				else
					lblSecret.Text = 'Guaranteed <font color="#FFFFFF">Secret</font> in ' .. formatTime(pitySecretTimer)
				end
			end
			if lblMythical then
				if mythicalPityActive then
					lblMythical.Text = 'Guaranteed <font color="#FF007F">Mythical</font> spawning now!'
				else
					lblMythical.Text = 'Guaranteed <font color="#FF007F">Mythical</font> in ' .. formatTime(pityMythicalTimer)
				end
			end

			task.wait(1)
		end
	end)
