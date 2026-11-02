-- Améliorations du dragon, achetées au stand "Upgrades".
-- Le niveau de chaque amélioration est un attribut du joueur : Up_Stamina, Up_Carry, Up_Speed.
local UpgradeConfig = {}

UpgradeConfig.Order = {"Stamina", "Carry", "Speed", "Burn"}

-- Base = valeur de départ, Step = gain par niveau, Top = valeur maximale.
-- Prix : soit une liste Costs (un prix par niveau), soit une courbe qui part de First et finit à Last au tout dernier niveau,
-- avec un saut de prix (x TierMult) chaque fois que la valeur passe un multiple de Tier (50, 100, 150...).
UpgradeConfig.Stats = {
	Stamina = {Title = "Stamina", Base = 30, CostOffset = 18, -- on commence à 30 ; les prix sont ceux d'un joueur qui aurait déjà acheté jusqu'à 30
		 Step = 1, Top = 300, First = 250, Last = 1e12, Robux = 9},
	Carry = {Title = "Carry", Base = 1, Step = 1, Top = 3, Costs = {500000, 50000000}, Robux = 80},
	Speed = {Title = "Speed", Base = 20, CostOffset = 4, -- on commence à 20 ; les prix sont ceux d'un joueur qui aurait déjà acheté jusqu'à 20 (même prix qu'avant pour une même vitesse)
		 Step = 1, Top = 300, First = 100, Last = 1e12, Robux = 3},
	-- puissance de brûlure (en %) : chaque zone d'œufs demande un minimum pour pouvoir brûler ses œufs
	Burn = {Title = "Burn", Base = 5, Step = 1, Top = 300, First = 150, Last = 1e12, Robux = 5, Suffix = "%"},
}
for _, stat in UpgradeConfig.Stats do
	stat.Max = math.floor((stat.Top - stat.Base) / stat.Step + 0.5) -- nombre de niveaux achetables
end

UpgradeConfig.Tier = 50            -- tous les 50 points de vitesse / d'endurance...
UpgradeConfig.TierMult = 5         -- ...les prix sont multipliés par 5
UpgradeConfig.BurnTime = 3         -- secondes de feu qu'il faut pour faire éclore un œuf
UpgradeConfig.GroundSpeedCap = 30  -- au sol, le dragon ne dépasse jamais cette vitesse ; en vol, il va à sa vraie vitesse

-- Endurance des ailes (unités par seconde)
UpgradeConfig.StaminaRise = 4.5      -- en montant
UpgradeConfig.StaminaFly = 1.125     -- en vol sans monter
UpgradeConfig.StaminaRegen = 5     -- au sol
UpgradeConfig.StaminaRestart = 2   -- une fois vide, il faut remonter à cette valeur pour redécoller

function UpgradeConfig.Level(player, key)
	return player:GetAttribute("Up_" .. key) or 0
end

function UpgradeConfig.ValueAt(key, level)
	local stat = UpgradeConfig.Stats[key]
	return math.min(stat.Base + stat.Step * level, stat.Top) -- jamais au-dessus du maximum, même si la valeur de départ a été relevée depuis
end

function UpgradeConfig.Value(player, key)
	return UpgradeConfig.ValueAt(key, UpgradeConfig.Level(player, key))
end

-- prix pour passer du niveau "level" au suivant
function UpgradeConfig.Cost(key, level)
	local stat = UpgradeConfig.Stats[key]
	if stat.Costs then return stat.Costs[level + 1] or stat.Costs[#stat.Costs] end
	-- paliers : nombre de multiples de Tier déjà franchis par la valeur actuelle
	local function tiers(value) return math.min(math.floor(value / UpgradeConfig.Tier), math.floor((stat.Top - 1) / UpgradeConfig.Tier)) end
	local lastTiers = tiers(UpgradeConfig.ValueAt(key, stat.Max - 1))
	-- hausse régulière entre deux paliers, calculée pour que le tout dernier niveau coûte exactement Last
	local growth = (stat.Last / (stat.First * UpgradeConfig.TierMult ^ lastTiers)) ^ (1 / math.max(1, stat.Max + (stat.CostOffset or 0) - 1))
	local cost = stat.First * growth ^ (level + (stat.CostOffset or 0)) * UpgradeConfig.TierMult ^ tiers(UpgradeConfig.ValueAt(key, level))
	-- arrondi à 3 chiffres significatifs pour des prix lisibles
	local magnitude = 10 ^ math.max(0, math.floor(math.log10(cost)) - 2)
	return math.floor(cost / magnitude + 0.5) * magnitude
end

return UpgradeConfig
