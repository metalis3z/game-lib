--!native
--khnam was here :p
local CaneService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local MAX_CANDIES = 50000

function CaneService:CanAfford(player: Player, amount: number): (boolean, number)
	assert(player)
	assert(amount)

	local playerChannel = Synchronizer:Get(player)
	assert(playerChannel)

	local currentCandies = playerChannel:Get("ChristmasEvent.CandyCane")
	assert(currentCandies)

	if currentCandies >= amount then
		return true, 0
	else
		return nil
	end
end

function CaneService:Add(player: Player, amount: number)
	assert(player)
	assert(amount)

	local playerChannel = Synchronizer:Get(player)
	assert(playerChannel)

	local currentCandies = playerChannel:Get("ChristmasEvent.CandyCane") or 0
	local newAmount = math.clamp(currentCandies + amount, 0, MAX_CANDIES)

	playerChannel:Set("ChristmasEvent.CandyCane", newAmount)
end

function CaneService:Set(player: Player, amount: number)
	assert(player)
	assert(amount)

	local playerChannel = Synchronizer:Get(player)
	assert(playerChannel)

	local clampedAmount = math.clamp(amount, 0, MAX_CANDIES)
	playerChannel:Set("ChristmasEvent.CandyCane", clampedAmount)
end

return CaneService