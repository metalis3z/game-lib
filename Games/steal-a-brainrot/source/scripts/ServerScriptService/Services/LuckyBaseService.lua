local LuckyBaseService = {}

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)

local AnimalsDB = require(ReplicatedStorage.Datas.Animals)
local IndexData = require(ReplicatedStorage.Datas.Index)
local IndexShared = require(ReplicatedStorage.Shared.Index)

local NotificationService = require(ServerScriptService.Services.NotificationService)

local ClaimBaseSkin = Net:RemoteEvent("LuckyBase/Claim")

local Config = {
	EVENT_NAME = "Lucky",
	REQUIRED_ANIMALS = nil,
	BASE_SKIN_ID = "Lucky",

	REWARDS = {
		BaseSkin = true,
		Coins = 0,
		Title = "Lucky Collector"
	}
}

local function GetLuckyAnimals(): {string}
	local LuckyAnimals = {}
	local LuckyIndex = IndexData["Lucky"] and IndexData["Lucky"].Index

	if not LuckyIndex then
		warn("[LuckyBaseService] Lucky index not found")
		return LuckyAnimals
	end

	for animalName, _ in pairs(LuckyIndex) do
		if AnimalsDB[animalName] then
			table.insert(LuckyAnimals, animalName)
		end
	end

	table.sort(LuckyAnimals, function(a, b)
		local dataA = AnimalsDB[a]
		local dataB = AnimalsDB[b]
		return (dataA.Generation or 0) < (dataB.Generation or 0)
	end)

	return LuckyAnimals
end

local function HasAllLuckyAnimals(player: Player): boolean
	local data = Synchronizer:Get(player)
	if not data then return false end

	local owned, required = IndexShared:GetIndexAnimals(player, Config.EVENT_NAME)
	return owned >= required
end

local function HasClaimedReward(player: Player): boolean
	local data = Synchronizer:Get(player)
	if not data then return false end

	local unlockedSkins = data:Get("UnlockedBaseSkins") or {}
	return unlockedSkins[Config.BASE_SKIN_ID] ~= nil
end

local function GrantBaseSkin(player: Player): boolean
	local data = Synchronizer:Get(player)
	if not data then return false end

	if HasClaimedReward(player) then
		return false
	end

	if not HasAllLuckyAnimals(player) then
		return false
	end

	local unlockedSkins = data:Get("UnlockedBaseSkins") or {}
	unlockedSkins[Config.BASE_SKIN_ID] = true
	data:Set("UnlockedBaseSkins", unlockedSkins)

	if Config.REWARDS.Coins then
		local currentCoins = data:Get("Coins") or 0
		data:Set("Coins", currentCoins + Config.REWARDS.Coins)
	end

	if Config.REWARDS.Title then
		local titles = data:Get("UnlockedTitles") or {}
		if not table.find(titles, Config.REWARDS.Title) then
			table.insert(titles, Config.REWARDS.Title)
			data:Set("UnlockedTitles", titles)
		end
	end

	NotificationService.Success(
		player,
		string.format(" Claimed Lucky Base Skin! +$%s", 
			require(ReplicatedStorage.Utils.NumberUtils):Comma(Config.REWARDS.Coins or 0)
		),
		7
	)

	return true
end

ClaimBaseSkin.OnServerEvent:Connect(function(player: Player)
	GrantBaseSkin(player)
end)

function LuckyBaseService:Start()

	ReplicatedStorage:SetAttribute("LuckyBaseEvent", true)

	Config.REQUIRED_ANIMALS = GetLuckyAnimals()

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			local data = Synchronizer:Wait(player)
			if data then

				if not data:Get("UnlockedBaseSkins") then
					data:Set("UnlockedBaseSkins", {})
				end
			end
		end)
	end

	Players.PlayerAdded:Connect(function(player)
		local data = Synchronizer:Wait(player)
		if data then
			if not data:Get("UnlockedBaseSkins") then
				data:Set("UnlockedBaseSkins", {})
			end
		end
	end)
end

function LuckyBaseService:GetProgress(player: Player): {owned: number, required: number, claimed: boolean}
	local owned, required = IndexShared:GetIndexAnimals(player, Config.EVENT_NAME)
	local claimed = HasClaimedReward(player)

	return {
		owned = owned,
		required = required,
		claimed = claimed,
		canClaim = owned >= required and not claimed
	}
end

function LuckyBaseService:GetRequiredAnimals(): {string}
	return Config.REQUIRED_ANIMALS or {}
end

function LuckyBaseService:ForceGrant(player: Player)
	local data = Synchronizer:Get(player)
	if not data then return false end

	local unlockedSkins = data:Get("UnlockedBaseSkins") or {}
	unlockedSkins[Config.BASE_SKIN_ID] = true
	data:Set("UnlockedBaseSkins", unlockedSkins)
	
	return true
end

function LuckyBaseService:ResetProgress(player: Player)
	local data = Synchronizer:Get(player)
	if not data then return false end

	local unlockedSkins = data:Get("UnlockedBaseSkins") or {}
	unlockedSkins[Config.BASE_SKIN_ID] = nil
	data:Set("UnlockedBaseSkins", unlockedSkins)

	return true
end

return LuckyBaseService