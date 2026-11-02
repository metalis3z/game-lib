-- Game: smash-egg-for-animals
-- Original: ServerScriptService/EggZoneServer.server.lua
-- Excerpt of lines 84-107, 297-326, 1037-1065
-- What it does: Three roll helpers: luck() reads a server attribute, rollHeight() picks a size tier, pickKey() boosts every egg except the most common one during a luck event, and hatch() picks the pet and stacks event mutations.
-- Note: Original comments are in French.
-- ===== Excerpt of lines 84-107 of ServerScriptService/EggZoneServer.server.lua =====

-- les oeufs d'une rareté, du moins bon au meilleur (même ordre que les chances de Config.SpawnChances)
local function eggKeysOf(rarity)
	return Config.EggsByValue(rarity)
end

-- evenement "x4 LUCK" : multiplicateur pose par LuckEventServer (1 = normal)
local function luck()
	local value = ReplicatedStorage:GetAttribute("LuckMultiplier")
	return type(value) == "number" and math.max(value, 1) or 1
end

local function rollHeight()
	local roll = math.random() * 100
	for _, tier in SIZE_TIERS do
		roll -= tier.Chance * luck()
		if roll <= 0 then -- (deuxième valeur : le poids imposé par ce palier, s'il en a un)
			return (tier.Min + math.random() * (tier.Max - tier.Min)) * PLAYER_HEIGHT, tier.Kg and (tier.Kg[1] + math.random() * (tier.Kg[2] - tier.Kg[1])) or nil
		end
	end
	return NORMAL_HEIGHT[1] + math.random() * (NORMAL_HEIGHT[2] - NORMAL_HEIGHT[1])
end

-- plus de dragon : le joueur porte lui-même ce qu'il ramène. Son personnage tient le rôle du porteur dans tout ce script

-- ===== Excerpt of lines 297-326 of ServerScriptService/EggZoneServer.server.lua =====

-- tire un oeuf parmi ceux d'une rareté : le premier a 60 % de chance, le meilleur 1 % (Config.SpawnChances).
-- Pendant un event de chance, tous les oeufs sauf le premier voient leur chance multipliée.
local function pickKey(keys)
	local first = Config.Eggs[keys[1] ]
	if first and first.SpawnWeight then
		local chances = {}
		for i, key in keys do chances[i] = Config.Eggs[key].SpawnWeight or 0 end
		local L = luck()
		local total = 0
		for i in keys do total += chances[i] * (i > 1 and L or 1) end
		local roll = math.random() * total
		for i, key in keys do
			roll -= chances[i] * (i > 1 and L or 1)
			if roll <= 0 then return key end
		end
		return keys[1]
	end
	local chances = Config.SpawnChancesFor(#keys)
	local L = luck()
	local total = 0
	for i in keys do total += chances[i] * (i > 1 and L or 1) end
	local roll = math.random() * total
	for i, key in keys do
		roll -= chances[i] * (i > 1 and L or 1)
		if roll <= 0 then return key end
	end
	return keys[1]
end

-- ===== Excerpt of lines 1037-1065 of ServerScriptService/EggZoneServer.server.lua =====
local function hatch(player, egg, zone)
	egg:SetAttribute("Hatching", true)
	local key, kg, height = egg:GetAttribute("EggKey"), egg:GetAttribute("Kg"), egg:GetAttribute("Height")
	local info = Config.Eggs[key]
	assert(info and info.Pets and info.Pets[1], "unknown egg " .. tostring(key))
	kg = tonumber(kg) or info.Kg or 1
	height = tonumber(height) or 4
	-- quel animal ? tirage selon les pourcentages de l'œuf (un ancien œuf n'a qu'un animal à 100 %)
	local petName = info.Pets[1].Pet
	if #info.Pets > 1 then
		local total = 0
		for _, entry in info.Pets do total += entry.Chance end
		local roll = math.random() * total
		for _, entry in info.Pets do
			roll -= entry.Chance
			if roll <= 0 then petName = entry.Pet break end
		end
	end
	local petInfo = Config.Pets[petName]
	egg:SetAttribute("CrackTime", CRACK_TIME) -- l'œuf craque pendant ce temps (HatchFxClient)
	-- les kilos en plus de l'œuf passent à l'animal : œuf géant = animal géant
	local petKg = math.min(petInfo.Kg * (1 + math.random() * 0.25) + math.max(0, kg - info.Kg), Config.MaxKg or 1e6)
	local entry = {Key = key, Kg = kg, Height = height, Zone = zone, Pet = petName, PetKg = petKg, Witch = egg:GetAttribute("WitchTrait"), Cowboy = egg:GetAttribute("CowboyTrait"),
		Concert = (function() -- mutations d'event (Like du concert, Disco, Galaxy... qui s'empilent : "Like+Disco+Galaxy") : l'animal les garde toutes
			local all = egg:GetAttribute("ConcertMutation") and "Like" or nil
			for _, m in Config.MutationList(egg:GetAttribute("EventMutation")) do all = all and Config.AddMutation(all, m) or m end
			return all
		end)()} -- mutation d'event (Like x5 du CONCERT, Cosmic / Storm / Alien x4 des events du ciel) : l'animal la garde
	if not egg:GetAttribute("Dropped") then task.delay(RESPAWN_DELAY, spawnEgg, zone) end
