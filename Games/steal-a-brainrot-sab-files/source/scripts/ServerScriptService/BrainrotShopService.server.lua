-- GamepassSpawn.lua
-- Mettre dans : ServerScriptService → Script
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Animals = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(game.ServerScriptService.Services.AnimalService)

local GAMEPASS_BRAINROT = {
	[1898108762] = "Headless Horseman",
	[1919290044] = "Strawberry Elephant",
	[1852719482] = "Flying Carpet",
	[1898358256] = "Skibidi Toilet",
	[1896108882] = "Garama and Madundung",
	[1895680875] = "Ketupat Kepat",
	[1898310262] = "Burguro And Fryuro",
	[1898850604] = "OG Lucky Block",
	[1898178282] = "La Secret Combinasion",
	[1895850850] = "Spaghetti Tualetti",
	[1896264874] = "Dragon Cannelloni",
}

local function spawnBrainrot(player, brainrotName)
	local animalKey = nil
	for key, data in pairs(Animals) do
		if data.DisplayName == brainrotName or data.Name == brainrotName then
			animalKey = key
			break
		end
	end
	if not animalKey then
		if Animals[brainrotName] then
			animalKey = brainrotName
		end
	end
	if not animalKey then
		warn("Brainrot introuvable : " .. tostring(brainrotName))
		return
	end
	AnimalService.spawnAnimalCustom(Animals[animalKey], nil, {}, nil, {Owner = player})
end

-- Spawn UNIQUEMENT quand quelqu'un achete
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamepassId, wasPurchased)
	if not wasPurchased then return end
	local brainrotName = GAMEPASS_BRAINROT[gamepassId]
	if brainrotName then
		spawnBrainrot(player, brainrotName)
	end
end)
