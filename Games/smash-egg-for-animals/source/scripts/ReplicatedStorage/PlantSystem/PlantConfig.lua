-- Configuration des graines et des plantes (les kilos, mutations et formats viennent de EggConfig)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))

local rgb = Color3.fromRGB

local PlantConfig = {}

PlantConfig.MaxPlanted = 20    -- plantes en même temps dans la partie "plantes" du jardin
PlantConfig.MaxSeeds = 200     -- graines max en stock (toutes sortes confondues)
PlantConfig.MaxCrops = 100     -- plantes récoltées max dans l'inventaire
PlantConfig.OwnerGrowTime = 5  -- temps de pousse (s) pour le créateur, quelle que soit la graine
PlantConfig.MinSpacing = 2.5   -- distance minimale entre deux plantes
PlantConfig.StartScale = 0.2   -- taille de la pousse au moment où on plante (1 = plante mûre)

-- Price = prix de la graine, Xp = XP donnée à un animal au poids normal,
-- GrowTime = temps de pousse en secondes au poids normal (une plante plus lourde pousse plus longtemps),
-- Kg = poids normal de la récolte, Color = couleur du sachet
PlantConfig.Seeds = {
	Carrot = {Order = 1, Name = "Carrot", Rarity = "Common", Price = 25, Xp = 10, GrowTime = 20, Kg = 0.2, Color = rgb(255, 140, 30)},
	Potato = {Order = 2, Name = "Potato", Rarity = "Common", Price = 150, Xp = 40, GrowTime = 45, Kg = 0.4, Color = rgb(190, 150, 90)},
	Cabbage = {Order = 3, Name = "Cabbage", Rarity = "Uncommon", Price = 800, Xp = 150, GrowTime = 90, Kg = 1.5, Color = rgb(130, 210, 110)},
	Corn = {Order = 4, Name = "Corn", Rarity = "Rare", Price = 4000, Xp = 600, GrowTime = 180, Kg = 0.5, Color = rgb(255, 220, 60)},
	Tomato = {Order = 5, Name = "Tomato", Rarity = "Epic", Price = 20000, Xp = 2500, GrowTime = 300, Kg = 0.3, Color = rgb(230, 50, 40)},
	Pumpkin = {Order = 6, Name = "Pumpkin", Rarity = "Legendary", Price = 90000, Xp = 10000, GrowTime = 600, Kg = 8, Color = rgb(255, 130, 20)},
	Watermelon = {Order = 7, Name = "Watermelon", Rarity = "Mythic", Price = 350000, Xp = 40000, GrowTime = 900, Kg = 12, Color = rgb(60, 170, 80)},
}

-- XP donnée par une plante récoltée : XP normale x (petite variation de poids + kilos bonus) x mutation
function PlantConfig.GetXp(seedName, kg, mutationName)
	local info = PlantConfig.Seeds[seedName]
	if not info then return 0 end
	local mutation = mutationName and EggConfig.GetMutation(mutationName)
	local weight = math.clamp(kg / info.Kg, 0.5, 1.3) + math.max(0, kg - info.Kg) / EggConfig.IncomeStepKg
	return math.max(1, math.floor(info.Xp * weight * (mutation and mutation.Mult or 1) + 0.5))
end

function PlantConfig.IsOwner(userId)
	return table.find(EggConfig.OwnerUserIds, userId) ~= nil
end

-- Temps de pousse : fixe pour le créateur ; pour les autres il grandit avec le poids (comme la taille)
function PlantConfig.GetGrowTime(seedName, kg, userId)
	if PlantConfig.IsOwner(userId) then return PlantConfig.OwnerGrowTime end
	return math.floor(PlantConfig.Seeds[seedName].GrowTime * EggConfig.SizeScale(kg) + 0.5)
end

return PlantConfig
