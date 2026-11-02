--!strict
-- LOCATION: ServerScriptService/MorphRewardHandler

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Events = ReplicatedStorage:WaitForChild("Events")
local ServerModules = ServerScriptService:WaitForChild("Modules")

-- Require your ItemManager
local ItemManager = require(ServerModules:WaitForChild("ItemManager"))

-- Create the remote event if it doesn't exist
local ClaimEvent = Events:FindFirstChild("ClaimHatchedItem")
if not ClaimEvent then
	ClaimEvent = Instance.new("RemoteEvent")
	ClaimEvent.Name = "ClaimHatchedItem"
	ClaimEvent.Parent = Events
end

-- Securely handle the item reward when the player escapes the zone
ClaimEvent.OnServerEvent:Connect(function(player: Player, itemName: string, rarity: string)
	if not itemName then return end

	-- We default to "Normal" mutation and Level 1 since hatched items start at base stats
	local safeRarity = rarity or "Common"
	local defaultMutation = "Normal"
	local defaultLevel = 1
	local isTemporary = false

	print("[MorphRewardHandler] Asking ItemManager to construct tool:", itemName, "(Rarity:", safeRarity .. ")")

	-- Use the EXACT function name and parameters found in your ItemManager
	if type(ItemManager.GiveItemToPlayer) == "function" then
		ItemManager.GiveItemToPlayer(player, itemName, defaultMutation, safeRarity, defaultLevel, isTemporary)
	else
		warn("[MorphRewardHandler] CRITICAL ERROR: GiveItemToPlayer function is still missing from ItemManager!")
	end
end)