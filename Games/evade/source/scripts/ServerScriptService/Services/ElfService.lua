local ElfService = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local MAX_ELVES = 5000 

function ElfService:CanAfford(player: Player, amount: number): (boolean, number)
	assert(player, "Player required")
	assert(amount, "Amount required")
	assert(amount > 0, "Amount must be positive")

	local playerChannel = Synchronizer:Get(player)
	assert(playerChannel, "Player channel not loaded")

	local currentElves = playerChannel:Get("ChristmasEvent.GoldElves") or 0
	return currentElves >= amount, currentElves
end

function ElfService:Add(player: Player, amount: number)
	assert(player, "Player required")
	assert(amount, "Amount required")

	local playerChannel = Synchronizer:Get(player)
	assert(playerChannel, "Player channel not loaded")

	local currentElves = playerChannel:Get("ChristmasEvent.GoldElves") or 0
	local newAmount = math.clamp(currentElves + amount, 0, MAX_ELVES)
	playerChannel:Set("ChristmasEvent.GoldElves", newAmount)
end

function ElfService:Set(player: Player, amount: number)
	assert(player, "Player required")
	assert(amount, "Amount required")

	local playerChannel = Synchronizer:Get(player)
	assert(playerChannel, "Player channel not loaded")

	local clampedAmount = math.clamp(amount, 0, MAX_ELVES)
	playerChannel:Set("ChristmasEvent.GoldElves", clampedAmount)
end

return ElfService