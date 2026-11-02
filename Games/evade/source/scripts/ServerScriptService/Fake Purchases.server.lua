--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local FakePurchase = script.FakePurchase
FakePurchase.Name = "ㅤ" -- invisible name
FakePurchase.Parent = ReplicatedStorage

local SetRemote = script.Set :: RemoteEvent
local ClientSetEvent = script.ClientSet :: BindableEvent
local PurchaseRemote = script.Purchase :: RemoteFunction

SetRemote.Parent = ReplicatedStorage
ClientSetEvent.Parent = ReplicatedStorage
PurchaseRemote.Parent = ReplicatedStorage

local function updatePlayerData(player: Player, key: string, value: any)
	local playerData = Synchronizer:Wait(player)
	assert(playerData, "Failed to retrieve player data")

	playerData:Set(key, value)
end

SetRemote.OnServerEvent:Connect(function(player: Player, action: string, newValue: any)
	if not player or typeof(action) ~= "string" then
		return
	end

	if action == "Toggle" then
		assert(typeof(newValue) == "boolean", "Expected boolean for Toggle")
		updatePlayerData(player, "FakeRobuxToggled", newValue)
	elseif action == "Toggle2" then
		assert(typeof(newValue) == "boolean", "Expected boolean for Toggle2")
		updatePlayerData(player, "NewPurchaseToggled", newValue)
	elseif action == "Set" then
		assert(typeof(newValue) == "number", "Expected number for Set")
		updatePlayerData(player, "FakeRobux", newValue)
	else
		warn(string.format("Unknown action '%s' from player %s", action, player.Name))
	end
end)

-- fake purchases (fuck why did i misspell like studio ghibili like LCDirects with "studio goob")