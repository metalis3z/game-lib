local MoneyService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

function MoneyService:CanAfford(player: Player, amount: number): (boolean, number)
	assert(player)
	assert(amount)

	local playerChannel = Synchronizer:Get(player)
	assert(playerChannel)

	local currentCoins = playerChannel:Get("Coins")
	assert(currentCoins)

	if currentCoins >= amount then
		return true, 0
	else
		return false, amount - currentCoins
	end
end

function MoneyService:Add(player: Player, amount: number)
	assert(player)
	assert(amount)

	local playerChannel = Synchronizer:Get(player)
	assert(playerChannel)

	playerChannel:Increase("Coins", amount)
end

function MoneyService:Set(player: Player, amount: number)
	assert(player)
	assert(amount)

	local playerChannel = Synchronizer:Get(player)
	assert(playerChannel)

	playerChannel:Set("Coins", amount)
end

return MoneyService