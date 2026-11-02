-- Les dragons de la boutique. Key = nom du modèle dans ReplicatedStorage.Dragons.
-- Le premier est offert ; les autres s'achètent avec l'argent du jeu. L'attribut "Dragon" du joueur = dragon équipé,
-- "OwnedDragons" = liste des dragons possédés (séparés par des virgules).
local DragonConfig = {}

DragonConfig.Starter = "Fire Dragon"

DragonConfig.List = {
	{Key = "Fire Dragon", Name = "Fire Dragon", Price = 0, Tagline = "Your first dragon"},
	{Key = "Ice Dragon", Name = "Ice Dragon", Price = 10000, Tagline = "Frozen scales, icy breath"},
	{Key = "Forest Dragon", Name = "Forest Dragon", Price = 75000, Tagline = "Guardian of the woods"},
	{Key = "Ocean Dragon", Name = "Ocean Dragon", Price = 400000, Tagline = "Rides the deepest waves"},
	{Key = "Thunder Dragon", Name = "Thunder Dragon", Price = 2500000, Tagline = "Crackling with lightning"},
	{Key = "Lava Dragon", Name = "Lava Dragon", Price = 15000000, Tagline = "Molten rock and embers"},
	{Key = "Crystal Dragon", Name = "Crystal Dragon", Price = 100000000, Tagline = "Shining like a gem"},
	{Key = "Shadow Dragon", Name = "Shadow Dragon", Price = 750000000, Tagline = "Born in the dark"},
	{Key = "Void Dragon", Name = "Void Dragon", Price = 5000000000, Tagline = "From beyond the stars"},
	{Key = "Celestial Dragon", Name = "Celestial Dragon", Price = 50000000000, Tagline = "A legend of light"},
	-- dragons d'Halloween (modèles construits par ServerStorage.HalloweenDragons)
	{Key = "Zombie Dragon", Name = "Zombie Dragon", Price = 500000000000, Tagline = "Back from the grave"},       -- 500B
	{Key = "Vampire Dragon", Name = "Vampire Dragon", Price = 2500000000000, Tagline = "Thirsty for blood"},      -- 2.5T
	{Key = "Halloween Dragon", Name = "Halloween Dragon", Price = 10000000000000, Tagline = "Trick or treat!"},   -- 10T
}

-- chaque dragon donne plus d'endurance que le précédent : x1, x1.2, x1.4, x1.6...
for order, dragon in DragonConfig.List do
	dragon.StaminaMult = 1 + 0.2 * (order - 1)
end

function DragonConfig.Get(key)
	for order, dragon in DragonConfig.List do
		if dragon.Key == key then return dragon, order end
	end
	return nil
end

function DragonConfig.Owns(player, key)
	if key == DragonConfig.Starter then return true end
	for name in string.gmatch(player:GetAttribute("OwnedDragons") or "", "[^,]+") do
		if name == key then return true end
	end
	return false
end

-- multiplicateur d'endurance du dragon équipé
function DragonConfig.StaminaMult(player)
	local dragon = DragonConfig.Get(player:GetAttribute("Dragon"))
	return dragon and dragon.StaminaMult or 1
end

function DragonConfig.Equipped(player)
	local key = player:GetAttribute("Dragon")
	return DragonConfig.Get(key) and key or DragonConfig.Starter
end

return DragonConfig
