local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

-- Developer Product IDs
local PRODUCT_ID_HEADLESS_HORSEMAN = 3611965515
local PRODUCT_ID_MEOWL = 3610327634
local PRODUCT_ID_SKIBIDI_TOILET = 3611965549
local PRODUCT_ID_STRAWBERRY_ELEPHANT = 3611965467
local PRODUCT_ID_ULTIME_LUCKY_BLOCK = 3612055210

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local MUTATION_CHANCES = {
	{ name = "Gold", chance = 40 },
	{ name = "Rainbow", chance = 10 },
	{ name = "Radioactive", chance = 8 },
	{ name = "Lava", chance = 7 },
	{ name = "Candy", chance = 5 },
	{ name = "Galaxy", chance = 4 },
	{ name = "Cyber", chance = 3 },
	{ name = "YinYang", chance = 2 },
	{ name = "Bloodrot", chance = 1 },
}

local function getRandomMutation()
	local roll = math.random(1,100)
	local total = 0

	for _, entry in ipairs(MUTATION_CHANCES) do
		total += entry.chance

		if roll <= total then
			return entry.name
		end
	end

	return nil
end

local Animals = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(ServerScriptService.Services.AnimalService)

local function spawnBrainrotForPlayer(player, animalName)

	local animalData = Animals[animalName]

	if not animalData then
		warn("Animal introuvable : "..animalName)
		return
	end

	local success, err = pcall(function()

		AnimalService.spawnAnimalCustom(
			animalData,
			getRandomMutation(),
			{},
			nil,
			{
				Owner = player
			},
			nil
		)

	end)

	if success then

		NotificationEvent:FireClient(
			player,
			"🎉 Merci pour votre achat ! Vous avez reçu : "..animalName,
			5,
			nil,
			"Top"
		)

		print(player.Name.." a reçu "..animalName)

	else

		warn(err)

	end
end

MarketplaceService.ProcessReceipt = function(receiptInfo)

	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)

	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local productId = receiptInfo.ProductId

	if productId == PRODUCT_ID_HEADLESS_HORSEMAN then

		spawnBrainrotForPlayer(player, "Headless Horseman")

	elseif productId == PRODUCT_ID_MEOWL then

		spawnBrainrotForPlayer(player, "Meowl")

	elseif productId == PRODUCT_ID_SKIBIDI_TOILET then

		spawnBrainrotForPlayer(player, "Skibidi Toilet")

	elseif productId == PRODUCT_ID_STRAWBERRY_ELEPHANT then

		spawnBrainrotForPlayer(player, "Strawberry Elephant")
		
	elseif productId == PRODUCT_ID_ULTIME_LUCKY_BLOCK then 
		
		spawnBrainrotForPlayer(player, "Ultime Lucky Block")
		
	end 

	return Enum.ProductPurchaseDecision.PurchaseGranted
end

print("DeveloperProductBrainrotSpawner chargé.")