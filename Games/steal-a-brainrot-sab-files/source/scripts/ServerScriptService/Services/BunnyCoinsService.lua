--!native
local BunnyCoinsService = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local MAX_BUNNY_COINS = 50000
local KEY = "EasterEvent.BunnyCoins"

function BunnyCoinsService:Get(player: Player): number
	assert(player)
	local channel = Synchronizer:Get(player)
	if not channel then return 0 end
	local value = channel:Get(KEY)
	return value or 0
end

function BunnyCoinsService:CanAfford(player: Player, amount: number): boolean
	assert(player)
	assert(amount)
	return BunnyCoinsService:Get(player) >= amount
end

function BunnyCoinsService:Add(player: Player, amount: number)
	assert(player)
	assert(amount)
	local channel = Synchronizer:Get(player)
	assert(channel, "No channel for player: " .. player.Name)
	local newAmount = math.clamp(BunnyCoinsService:Get(player) + amount, 0, MAX_BUNNY_COINS)
	channel:Set(KEY, newAmount)
end

function BunnyCoinsService:Set(player: Player, amount: number)
	assert(player)
	assert(amount)
	local channel = Synchronizer:Get(player)
	assert(channel, "No channel for player: " .. player.Name)
	channel:Set(KEY, math.clamp(amount, 0, MAX_BUNNY_COINS))
end

return BunnyCoinsService