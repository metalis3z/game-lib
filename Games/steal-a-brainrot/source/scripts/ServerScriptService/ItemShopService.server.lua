local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

-- Create RemoteEvent for free items from ItemShop
local freeItemRemote = Instance.new("RemoteEvent")
freeItemRemote.Name = "ItemShopFreeItem"
freeItemRemote.Parent = ReplicatedStorage

-- Handle free item requests
freeItemRemote.OnServerEvent:Connect(function(player, itemName)
	if type(itemName) ~= "string" then return end
	if #itemName > 100 then return end

	-- Only allow "Flying Carpet" as a free item
	if itemName ~= "Flying Carpet" then return end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		warn("[ItemShop] No player channel for", player.Name)
		return
	end

	-- Check if already owned
	local alreadyOwned = playerChannel:Get(("Items.%s"):format(itemName))
	if alreadyOwned then
		print("[ItemShop]", player.Name, "already owns", itemName)
		return
	end

	-- Grant the item (same logic as ShopService for Type == "Item")
	playerChannel:InsertOnDictionary("Items", itemName, true)
	playerChannel:InsertOnDictionary("Gamepass", itemName, true)
	print("[ItemShop] Granted free item", itemName, "to", player.Name)
end)
