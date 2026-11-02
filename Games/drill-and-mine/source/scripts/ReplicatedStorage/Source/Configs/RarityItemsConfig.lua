-- RarityItemsConfig: index of every underground loot item.
-- Templates live in ReplicatedStorage.RarityItems.<Rarity>.<ItemName>.
-- Zones: deeper zone number = rarer loot. A zone's spawn pool is every
-- rarity whose [ZoneMin, ZoneMax] range covers that zone, weighted by Weight.

local RarityItemsConfig = {}

RarityItemsConfig.RarityOrder = {
	"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Godly", "Secret", "Divine", "Rainbow",
}

-- Tight zone ranges (user request: a zone two steps deeper must feel almost
-- completely new): each rarity lives ~4 zones -- 1 shared entry zone, ~2
-- solo zones, 1 shared exit zone. Divine holds the 24-30 endgame stretch;
-- its ITEMS still rotate there via GetZoneItemPool's sliding windows.
-- Value = the rarity's BASE sell price; GetItemValue spreads each rarity's
-- items from 1x to ~2.2x that base (list order = cheap -> pricey), so the
-- Commons pay $50..$110. Retuned 2026-07-16 (user: "progression too slow;
-- zone 3 should drop $1K-$5K items"): Uncommon (enters at zone 3) jumped
-- $500 -> $2K, and every mid tier was raised so each zone band comfortably
-- funds the drills meant for that stage (GameConfig.Drills ladder). The
-- Divine endgame anchor stays $50B (a full Divine backpack run still
-- yields trillions for the $100T-$300T endgame drills).
RarityItemsConfig.Rarities = {
	Common    = { Order = 1, Value = 50,            Color = Color3.fromRGB(215, 215, 215), ZoneMin = 1,  ZoneMax = 3,  Weight = 100, Animated = false, LifeMin = 90, LifeMax = 150 },
	Uncommon  = { Order = 2, Value = 2000,          Color = Color3.fromRGB(88, 214, 93),   ZoneMin = 3,  ZoneMax = 6,  Weight = 60,  Animated = false, LifeMin = 80, LifeMax = 140 },
	Rare      = { Order = 3, Value = 15000,         Color = Color3.fromRGB(66, 140, 255),  ZoneMin = 6,  ZoneMax = 9,  Weight = 35,  Animated = false, LifeMin = 75, LifeMax = 120 },
	Epic      = { Order = 4, Value = 150000,        Color = Color3.fromRGB(163, 86, 255),  ZoneMin = 9,  ZoneMax = 12, Weight = 20,  Animated = false, LifeMin = 70, LifeMax = 110 },
	Legendary = { Order = 5, Value = 2000000,       Color = Color3.fromRGB(255, 170, 40),  ZoneMin = 12, ZoneMax = 15, Weight = 10,  Animated = false, LifeMin = 60, LifeMax = 100 },
	Mythic    = { Order = 6, Value = 25000000,      Color = Color3.fromRGB(255, 64, 96),   ZoneMin = 15, ZoneMax = 18, Weight = 5,   Animated = true,  LifeMin = 55, LifeMax = 90 },
	Godly     = { Order = 7, Value = 300000000,     Color = Color3.fromRGB(255, 215, 0),   ZoneMin = 18, ZoneMax = 21, Weight = 2.5, Animated = true,  LifeMin = 50, LifeMax = 80 },
	Secret    = { Order = 8, Value = 4000000000,    Color = Color3.fromRGB(190, 140, 255), ZoneMin = 21, ZoneMax = 24, Weight = 1,   Animated = true,  LifeMin = 45, LifeMax = 70 },
	Divine    = { Order = 9, Value = 50000000000,   Color = Color3.fromRGB(80, 255, 255),  ZoneMin = 24, ZoneMax = 30, Weight = 0.5, Animated = true,  LifeMin = 40, LifeMax = 60 },
	-- Rainbow: ONE item (Rainbow Gem), spawning ONLY in zone 30 -- nowhere
	-- else in the game. The tiny Weight is deliberate: zone 30's pool is
	-- Divine at 0.125 effective (0.5 faded x0.25 at its range end) vs
	-- Rainbow at 0.003 x2.5 newest-unlock boost = 0.0075, so ~1 in 18
	-- spawns there is a Rainbow Gem. $2T makes it the single most
	-- expensive item in the game (above the $1T TheVoid store block).
	Rainbow   = { Order = 10, Value = 2000000000000, Color = Color3.fromRGB(255, 85, 255), ZoneMin = 30, ZoneMax = 30, Weight = 0.003, Animated = true, LifeMin = 40, LifeMax = 60 },
}

-- Explicit item index (mirrors the template folders; names are the display names).
-- Catalog synced to "+1 Kick Door Per Click" 2026-07-19 (same 67 items,
-- same rarity assignment and list order = same value spread).
RarityItemsConfig.Items = {
	Common    = { "Bone", "Apple", "Mushroom", "Duck", "Coin", "Meat" },
	Uncommon  = { "Ring", "Pearl", "Ruby", "Cash", "Bag of Money" },
	Rare      = { "Compass", "Hourglass", "Telescope", "Golden Key", "Treasure Map", "Gold Ingot", "Linked Sword", "Diamond" },
	Epic      = { "Golden Goblet", "Crossbow", "Diamond Gem", "Treasure Chest", "Gold Bar", "Robux Cash Stack", "Ancient Pot", "Golden Hat" },
	Legendary = { "Sapphire Crystal", "Crystal Cluster", "Magic Sword", "Celestial Star Orb", "Cristal", "Gravity Coil", "Gem", "Phoenix Feather", "Throne" },
	Mythic    = { "Moai Statue", "Thunder Hammer", "Crystal Orb", "Ancient Spellbook", "Ancient Drum", "Dragon Egg", "Magic Orb", "Night Fedora" },
	Godly     = { "Phoenix Fire Arrow", "Golden Idol Statue", "Bloxy Award", "Roblox Trophy", "Golden Trophy" },
	Secret    = { "Royal Scepter", "Cosmos Magic Staff", "Lyre Harp", "Dragon Skull", "Horned Skull", "void ball", "Nuclear Waste", "UFO" },
	Divine    = { "Magic Portal", "Infinity Gauntlet", "Divine Scepter", "Crystal Ball", "Periastron Sword", "Fire Dominus", "Magic Carpet", "Dark Heart", "Black Hole" },
	Rainbow   = { "Rainbow Gem" },
}

-- Items that stay in the index/economy (value, rarity, Index card, sell)
-- but must NEVER drop as free zone loot or spawn-board drops.
-- Dragon Egg = the paid pedestal item (workspace.DevProduct1); a free
-- small copy floating in a zone with its own billboard duplicates it.
RarityItemsConfig.NoNaturalSpawn = {
	["Dragon Egg"] = true,
}

-- How many concurrent loot slots each zone runs (lucky-block-era density).
RarityItemsConfig.SlotsPerZone = 5
-- Delay range between a slot emptying and the next spawn.
RarityItemsConfig.RespawnDelayMin = 2
RarityItemsConfig.RespawnDelayMax = 6
-- Minimum XZ distance between two live items in the same zone.
RarityItemsConfig.MinSeparation = 10

function RarityItemsConfig.GetRarity(rarityName)
	return RarityItemsConfig.Rarities[rarityName]
end

function RarityItemsConfig.GetItemRarity(itemName)
	for rarityName, list in pairs(RarityItemsConfig.Items) do
		for _, name in ipairs(list) do
			if name == itemName then
				return rarityName
			end
		end
	end
	return nil
end

-- Per-item spread inside a rarity: item 1 in the list sells for the base
-- Value, the last for ~2.2x it, geometric in between, snapped to 2
-- significant digits so prices read clean ($85, not $84.32).
RarityItemsConfig.ItemValueSpread = 2.2

function RarityItemsConfig.GetItemValue(itemName)
	local rarityName = RarityItemsConfig.GetItemRarity(itemName)
	local cfg = rarityName and RarityItemsConfig.Rarities[rarityName]
	if not cfg then return 0 end
	local items = RarityItemsConfig.Items[rarityName]
	local index = items and table.find(items, itemName)
	local n = items and #items or 0
	if not index or n < 2 then return cfg.Value end
	local raw = cfg.Value * RarityItemsConfig.ItemValueSpread ^ ((index - 1) / (n - 1))
	local mag = 10 ^ math.max(math.floor(math.log10(raw)) - 1, 0)
	return math.floor(raw / mag + 0.5) * mag
end

-- Rarities eligible for a given zone number (1..30), with weights.
-- Zones must FEEL different from their neighbors (user request): the rarity
-- that unlocked most recently dominates its zones (weight x NewestRarityBoost)
-- while older rarities fade out linearly as the zone approaches the end of
-- their [ZoneMin, ZoneMax] range. E.g. zone 4 (Uncommon enters): ~77%
-- Uncommon / 23% Common; zone 5: ~86/14; zone 8 (Rare enters): ~78% Rare.
RarityItemsConfig.NewestRarityBoost = 2.5

function RarityItemsConfig.GetZonePool(zoneIndex)
	-- the newest unlock in this zone = the eligible rarity with the highest ZoneMin
	local newestMin = -1
	for _, cfg in pairs(RarityItemsConfig.Rarities) do
		if zoneIndex >= cfg.ZoneMin and zoneIndex <= cfg.ZoneMax and cfg.ZoneMin > newestMin then
			newestMin = cfg.ZoneMin
		end
	end
	local pool = {}
	for rarityName, cfg in pairs(RarityItemsConfig.Rarities) do
		if zoneIndex >= cfg.ZoneMin and zoneIndex <= cfg.ZoneMax then
			local weight = cfg.Weight
			if cfg.ZoneMin == newestMin then
				weight = weight * RarityItemsConfig.NewestRarityBoost
			else
				local span = math.max(cfg.ZoneMax - cfg.ZoneMin, 1)
				local t = (zoneIndex - cfg.ZoneMin) / span
				weight = weight * math.max(1 - 0.75 * t, 0.1)
			end
			table.insert(pool, { Rarity = rarityName, Weight = weight })
		end
	end
	return pool
end

-- Which of a rarity's ITEMS spawn in a given zone. Each item gets a 3-zone
-- sliding window spread across the rarity's range, so even inside one
-- rarity's zones the item lineup keeps rotating (zone z and z+2 share
-- almost nothing). Short ranges / tiny item lists just use everything.
local ITEM_WINDOW = 3

function RarityItemsConfig.GetZoneItemPool(rarityName, zoneIndex)
	local items = {}
	for _, name in ipairs(RarityItemsConfig.Items[rarityName] or {}) do
		if not RarityItemsConfig.NoNaturalSpawn[name] then
			table.insert(items, name)
		end
	end
	local cfg = RarityItemsConfig.Rarities[rarityName]
	local n = #items
	if not cfg or n <= 2 then return items end
	local span = cfg.ZoneMax - cfg.ZoneMin + 1
	if span <= ITEM_WINDOW then return items end

	local function windowStart(i)
		return cfg.ZoneMin + math.floor((i - 1) * (span - ITEM_WINDOW) / (n - 1) + 0.5)
	end

	local list = {}
	for i, name in ipairs(items) do
		local start = windowStart(i)
		if zoneIndex >= start and zoneIndex <= start + ITEM_WINDOW - 1 then
			table.insert(list, name)
		end
	end
	if #list >= 2 then return list end

	-- range-edge zones can overlap fewer than 2 windows; pad with the items
	-- whose windows sit closest so a zone never funnels to a single item
	local scored = {}
	for i, name in ipairs(items) do
		local center = windowStart(i) + (ITEM_WINDOW - 1) / 2
		table.insert(scored, { name = name, d = math.abs(zoneIndex - center) })
	end
	table.sort(scored, function(a, b) return a.d < b.d end)
	list = {}
	for i = 1, math.min(2, n) do
		table.insert(list, scored[i].name)
	end
	return list
end

function RarityItemsConfig.FormatValue(value)
	local function trim(n)
		local s = string.format("%.1f", n)
		return (s:gsub("%.0$", ""))
	end
	if value >= 1e12 then
		return "$" .. trim(value / 1e12) .. "T"
	elseif value >= 1e9 then
		return "$" .. trim(value / 1e9) .. "B"
	elseif value >= 1e6 then
		return "$" .. trim(value / 1e6) .. "M"
	elseif value >= 1e3 then
		return "$" .. trim(value / 1e3) .. "k"
	end
	return string.format("$%d", value)
end

return RarityItemsConfig
