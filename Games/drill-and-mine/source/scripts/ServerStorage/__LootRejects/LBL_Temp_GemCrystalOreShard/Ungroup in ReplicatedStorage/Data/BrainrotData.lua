--BrainrotData , PATH: Replicatedstorage>Data>BrainrotData
local CollectibleSystem = {
	-- Rarity tiers from most common to rarest
	RarityTiers = {
		"Common", "Uncommon", "Rare", "Epic", 
		"Legendary", "Mythical", "Cosmic", "Secret"
	};

	-- All collectible names (ordered from worst #1 to best #39)
	CollectibleNames = {
		-- Common (1-8)
		"Noobini Pizzanini",
		"Tung Tung Tung Sahur",
		"Lirilì Larilà",
		"Chimpanzini Bananini",
		"Fluriflura",
		"Boneca Ambalabu",
		"Glorbo Fruttodrillo",
		"Brr Brr Patapim",
		-- Uncommon (9-13)
		"Gangster Footera",
		"Burbaloni Loliloli",
		"Ta Ta Ta Ta Sahur",
		"Talpa Di Fero",
		"Bombardiro Crocodilo",
		-- Rare (14-18)
		"Bombombini Gusini",
		"Cappuccino Assassino",
		"Ballerina Cappuccina",
		"Cocofanto Elefanto",
		"Odin Din Din Dun",
		-- Epic (19-23)
		"Espresso Signora",
		"Frigo Camelo",
		"Tralalero Tralala",
		"Garama_and_Madundung",
		"Chef Crabracadabra",
		-- Legendary (24-28)
		"Chicleteira Bicicleteira",
		"Graipuss Medussi",
		"Agarrini la Palini",
		"Pot Hotspot",
		"Blueberrinni_Octopusini",
		-- Mythical (29-33)
		"Dragon Cannelloni",
		"La_Vacca_Saturno_Saturnita",
		"Orcalero Orcala",
		"Los Combinasionas",
		"La_Grande_Combinasion",
		-- Cosmic (34-36)
		"Unclito_Samito",
		"Los Tralaleritos",
		"Mythic Lucky Block",
		-- Secret (37-39)
		"Brainrot God Lucky Block",
		"Secret Lucky Block",
	};

	-- Raw drop chances for each collectible within their rarity tier
	-- Higher values = more likely to drop within that tier
	DropWeights = {
		Common = {
			["Noobini Pizzanini"] = 0.871;
			["Tung Tung Tung Sahur"] = 0.833;
			["Lirilì Larilà"] = 0.811;
			["Chimpanzini Bananini"] = 0.786;
			["Fluriflura"] = 0.758;
			["Boneca Ambalabu"] = 0.725;
			["Glorbo Fruttodrillo"] = 0.684;
			["Brr Brr Patapim"] = 0.631;
		};
		Uncommon = {
			["Gangster Footera"] = 0.871;
			["Burbaloni Loliloli"] = 0.833;
			["Ta Ta Ta Ta Sahur"] = 0.786;
			["Talpa Di Fero"] = 0.725;
			["Bombardiro Crocodilo"] = 0.684;
		};
		Rare = {
			["Bombombini Gusini"] = 0.871;
			["Cappuccino Assassino"] = 0.833;
			["Ballerina Cappuccina"] = 0.786;
			["Cocofanto Elefanto"] = 0.725;
			["Odin Din Din Dun"] = 0.684;
		};
		Epic = {
			["Espresso Signora"] = 0.871;
			["Frigo Camelo"] = 0.833;
			["Tralalero Tralala"] = 0.786;
			["Garama_and_Madundung"] = 0.725;
			["Chef Crabracadabra"] = 0.684;
		};
		Legendary = {
			["Chicleteira Bicicleteira"] = 0.871;
			["Graipuss Medussi"] = 0.833;
			["Agarrini la Palini"] = 0.786;
			["Pot Hotspot"] = 0.725;
			["Blueberrinni_Octopusini"] = 0.684;
		};
		Mythical = {
			["Dragon Cannelloni"] = 0.871;
			["La_Vacca_Saturno_Saturnita"] = 0.833;
			["Orcalero Orcala"] = 0.786;
			["Los Combinasionas"] = 0.725;
			["La_Grande_Combinasion"] = 0.684;
		};
		Cosmic = {
			["Unclito_Samito"] = 0.871;
			["Los Tralaleritos"] = 0.811;
			["Mythic Lucky Block"] = 0.725;
		};
		Secret = {
			["Brainrot God Lucky Block"] = 0.903;
			["Secret Lucky Block"] = 0.833;
		};
	};

	-- Normalized probabilities (calculated below)
	-- These convert the raw weights into actual percentages
	NormalizedDropChances = {
		Common = {};
		Uncommon = {};
		Rare = {};
		Epic = {};
		Legendary = {};
		Mythical = {};
		Cosmic = {};
		Secret = {};
	};
}

-- =========================================
-- NORMALIZE DROP CHANCES
-- Convert raw weights to actual probabilities (0-1)
-- =========================================
for _, rarityTier in ipairs(CollectibleSystem.RarityTiers) do
	local totalWeight = 0

	-- Sum all weights in this rarity tier
	for _, weight in pairs(CollectibleSystem.DropWeights[rarityTier]) do
		totalWeight = totalWeight + weight
	end

	-- Normalize each weight to a probability
	for collectibleName, weight in pairs(CollectibleSystem.DropWeights[rarityTier]) do
		CollectibleSystem.NormalizedDropChances[rarityTier][collectibleName] = weight / totalWeight
	end
end

-- =========================================
-- ICON ASSET IDs
-- Roblox asset IDs for each collectible's icon
-- Set to 123 as placeholder - replace with actual asset IDs
-- =========================================
CollectibleSystem.IconIDs = {
	-- Common
	["Noobini Pizzanini"] = 123;
	["Tung Tung Tung Sahur"] = 123;
	["Lirilì Larilà"] = 123;
	["Chimpanzini Bananini"] = 123;
	["Fluriflura"] = 123;
	["Boneca Ambalabu"] = 123;
	["Glorbo Fruttodrillo"] = 123;
	["Brr Brr Patapim"] = 123;
	-- Uncommon
	["Gangster Footera"] = 123;
	["Burbaloni Loliloli"] = 123;
	["Ta Ta Ta Ta Sahur"] = 123;
	["Talpa Di Fero"] = 123;
	["Bombardiro Crocodilo"] = 123;
	-- Rare
	["Bombombini Gusini"] = 123;
	["Cappuccino Assassino"] = 123;
	["Ballerina Cappuccina"] = 123;
	["Cocofanto Elefanto"] = 123;
	["Odin Din Din Dun"] = 123;
	-- Epic
	["Espresso Signora"] = 123;
	["Frigo Camelo"] = 123;
	["Tralalero Tralala"] = 123;
	["Garama_and_Madundung"] = 123;
	["Chef Crabracadabra"] = 123;
	-- Legendary
	["Chicleteira Bicicleteira"] = 123;
	["Graipuss Medussi"] = 123;
	["Agarrini la Palini"] = 123;
	["Pot Hotspot"] = 123;
	["Blueberrinni_Octopusini"] = 123;
	-- Mythical
	["Dragon Cannelloni"] = 123;
	["La_Vacca_Saturno_Saturnita"] = 123;
	["Orcalero Orcala"] = 123;
	["Los Combinasionas"] = 123;
	["La_Grande_Combinasion"] = 123;
	-- Cosmic
	["Unclito_Samito"] = 123;
	["Los Tralaleritos"] = 123;
	["Mythic Lucky Block"] = 123;
	-- Secret
	["Brainrot God Lucky Block"] = 123;
	["Secret Lucky Block"] = 123;
}

-- =========================================
-- BASE VALUE TABLE
-- Base worth/value for each collectible
-- Values scale from worst (1) to best (39)
-- =========================================
local BaseValues = {
	-- Common (2-20)
	["Noobini Pizzanini"] = 2;
	["Tung Tung Tung Sahur"] = 4;
	["Lirilì Larilà"] = 6;
	["Chimpanzini Bananini"] = 8;
	["Fluriflura"] = 10;
	["Boneca Ambalabu"] = 13;
	["Glorbo Fruttodrillo"] = 16;
	["Brr Brr Patapim"] = 20;
	-- Uncommon (25-100)
	["Gangster Footera"] = 25;
	["Burbaloni Loliloli"] = 40;
	["Ta Ta Ta Ta Sahur"] = 60;
	["Talpa Di Fero"] = 80;
	["Bombardiro Crocodilo"] = 100;
	-- Rare (150-500)
	["Bombombini Gusini"] = 150;
	["Cappuccino Assassino"] = 225;
	["Ballerina Cappuccina"] = 325;
	["Cocofanto Elefanto"] = 425;
	["Odin Din Din Dun"] = 500;
	-- Epic (750-2000)
	["Espresso Signora"] = 750;
	["Frigo Camelo"] = 1000;
	["Tralalero Tralala"] = 1300;
	["Garama_and_Madundung"] = 1650;
	["Chef Crabracadabra"] = 2000;
	-- Legendary (3000-8000)
	["Chicleteira Bicicleteira"] = 3000;
	["Graipuss Medussi"] = 4000;
	["Agarrini la Palini"] = 5250;
	["Pot Hotspot"] = 6500;
	["Blueberrinni_Octopusini"] = 8000;
	-- Mythical (12000-30000)
	["Dragon Cannelloni"] = 12000;
	["La_Vacca_Saturno_Saturnita"] = 16500;
	["Orcalero Orcala"] = 21000;
	["Los Combinasionas"] = 25500;
	["La_Grande_Combinasion"] = 30000;
	-- Cosmic (50000-150000)
	["Unclito_Samito"] = 50000;
	["Los Tralaleritos"] = 90000;
	["Mythic Lucky Block"] = 150000;
	-- Secret (250000-1000000)
	["Brainrot God Lucky Block"] = 250000;
	["Secret Lucky Block"] = 1000000;
}

-- =========================================
-- RARITY DROP CHANCES
-- Probability of getting each rarity tier
-- =========================================
CollectibleSystem.RarityDropChances = {
	Common = 0.4;      -- 40%
	Uncommon = 0.3;    -- 30%
	Rare = 0.2;        -- 20%
	Epic = 0.05;       -- 5%
	Legendary = 0.035; -- 3.5%
	Mythical = 0.01;   -- 1%
	Cosmic = 0.004;    -- 0.4%
	Secret = 0.001;    -- 0.1%
}

-- =========================================
-- LUCKY MODE RARITY CHANCES
-- Special boosted chances when "lucky mode" is active
-- =========================================
CollectibleSystem.LuckyModeRarityChances = {
	Common = 0.2;    -- 20%
	Uncommon = 0.2;  -- 20%
	Rare = 0.2;      -- 20%
	Epic = 0.2;      -- 20%
	Legendary = 0.05; -- 5%
	Mythical = 0.05;  -- 5%
	Cosmic = 0.05;    -- 5%
	Secret = 0.05;    -- 5%
}

-- =========================================
-- RARITY COLOR CODING
-- RGB colors for each rarity tier
-- =========================================
CollectibleSystem.RarityColors = {
	Common = Color3.fromRGB(206, 206, 206);    -- Gray
	Uncommon = Color3.fromRGB(103, 171, 15);   -- Green
	Rare = Color3.fromRGB(53, 221, 255);       -- Cyan
	Epic = Color3.fromRGB(174, 73, 187);       -- Purple
	Legendary = Color3.fromRGB(255, 208, 67);  -- Gold
	Mythical = Color3.fromRGB(255, 0, 255);    -- Magenta
	Cosmic = Color3.fromRGB(85, 0, 127);       -- Dark Purple
	Secret = Color3.fromRGB(255, 0, 0);        -- Red
}

-- =========================================
-- MUTATION SYSTEM
-- Special variants that modify collectible value and appearance
-- =========================================

-- Value multipliers for each mutation type
local MutationMultipliers = {
	None = 1;      -- 1x (normal)
	Emerald = 1.2; -- 1.2x value
	Gold = 1.5;    -- 1.5x value
	Blood = 2;     -- 2x value
	Diamond = 2.5; -- 2.5x value
}

-- Drop chances for mutations
CollectibleSystem.MutationDropChances = {
	None = 0.85;     -- 85% (no mutation)
	Emerald = 0.075; -- 7.5%
	Gold = 0.045;    -- 4.5%
	Blood = 0.025;   -- 2.5%
	Diamond = 0.005; -- 0.5%
}

-- Color coding for mutations
CollectibleSystem.MutationColors = {
	Emerald = Color3.fromRGB(0, 255, 0);     -- Bright Green
	Gold = Color3.fromRGB(255, 255, 127);    -- Yellow
	Blood = Color3.fromRGB(255, 0, 0);       -- Red
	Diamond = Color3.fromRGB(0, 255, 255);   -- Cyan
}

-- Functions to apply mutation visual effects
CollectibleSystem.MutationApplyFunctions = {
	-- No mutation - do nothing
	None = function(collectibleModel)
	end;

	-- Emerald mutation - turn everything green
	Emerald = function(collectibleModel)
		for _, part in ipairs(collectibleModel:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Color = Color3.fromRGB(0, 255, 0)
			end
		end
	end;

	-- Gold mutation - turn everything gold
	Gold = function(collectibleModel)
		for _, part in ipairs(collectibleModel:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Color = Color3.fromRGB(248, 217, 109)
			end
		end
	end;

	-- Blood mutation - turn everything red
	Blood = function(collectibleModel)
		for _, part in ipairs(collectibleModel:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Color = Color3.fromRGB(255, 0, 0)
			end
		end
	end;

	-- Diamond mutation - turn everything cyan
	Diamond = function(collectibleModel)
		for _, part in ipairs(collectibleModel:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Color = Color3.fromRGB(0, 255, 255)
			end
		end
	end;
}

-- =========================================
-- UTILITY FUNCTIONS
-- =========================================

-- Find which rarity tier a collectible belongs to
function CollectibleSystem.GetCollectibleRarity(collectibleName)
	for _, rarityTier in ipairs(CollectibleSystem.RarityTiers) do
		if CollectibleSystem.DropWeights[rarityTier][collectibleName] ~= nil then
			return rarityTier
		end
	end
	return nil
end

-- FIXED GetRate function with proper nil handling
function CollectibleSystem.GetRate(collectibleName, mutationType)
	-- Validate inputs
	if not collectibleName or type(collectibleName) ~= "string" then
		warn("[BrainrotData] Invalid collectibleName:", collectibleName)
		return 0
	end

	if not mutationType or type(mutationType) ~= "string" then
		warn("[BrainrotData] Invalid mutationType:", mutationType, "for", collectibleName)
		mutationType = "None"
	end

	-- Get base value
	local baseValue = BaseValues[collectibleName]
	if baseValue == nil then
		warn("[BrainrotData] Missing BaseValue for:", collectibleName)
		warn("[BrainrotData] Available brainrots:", table.concat(CollectibleSystem.CollectibleNames, ", "))
		return 0
	end

	-- Get multiplier
	local multiplier = MutationMultipliers[mutationType]
	if multiplier == nil then
		warn("[BrainrotData] Invalid mutation type:", mutationType, "for", collectibleName)
		warn("[BrainrotData] Using default multiplier (1x)")
		multiplier = 1
	end

	-- Both values are valid, perform calculation
	local result = baseValue * multiplier
	return math.round(result)
end

-- Calculate how much currency you get for selling a collectible
function CollectibleSystem.GetSellAmount(collectibleName, mutationType)
	local rate = CollectibleSystem.GetRate(collectibleName, mutationType)
	return rate * 10
end

-- =========================================
-- EXPORT MODULE
-- =========================================
return CollectibleSystem