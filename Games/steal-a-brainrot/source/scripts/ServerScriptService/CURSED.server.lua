---!native

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Animals = require(ReplicatedStorage.Datas.Animals)

local GAMEPASS_ID = 1904802290 -- 🔴 MET TON ID ICI

-- 🔓 unlock GOLD
local function unlockCursedIndex(player)
	local channel
	for i = 1, 20 do
		channel = Synchronizer:Get(player)
		if channel then break end
		task.wait(0.1)
	end
	if not channel then return end

	local index = channel:Get("Index") or {}

	for animalName in pairs(Animals) do
		index[animalName] = index[animalName] or {}
		index[animalName]["Cursed"] = true
	end

	channel:Set("Index", index)
end

-- 👤 JOIN
Players.PlayerAdded:Connect(function(player)
	local ownsPass = false
	pcall(function()
		ownsPass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASS_ID)
	end)

	if ownsPass then
		unlockCursedIndex(player)
	end
end)

-- 🛒 ACHAT EN JEU (sans rejoin)
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, passId, purchased)
	if passId == GAMEPASS_ID and purchased then
		unlockCursedIndex(player)
	end
end)
