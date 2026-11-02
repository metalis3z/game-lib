local LuckyBase = {}
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local NotificationService = require(ServerScriptService.Services.NotificationService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local SharedIndex = require(ReplicatedStorage.Shared.Index)
local LuckyIndexData = require(ReplicatedStorage.Datas.Index)
local ClaimRemote = Net:RemoteEvent("LuckyBase/Claim")

function LuckyBase.UpdateLuckyIndex(Player: Player, AnimalName: string)
	local LuckyIndex = LuckyIndexData.Lucky and LuckyIndexData.Lucky.Index
	if not LuckyIndex or not LuckyIndex[AnimalName] then return end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return end

	local CurrentEntry = PlayerChannel:Get({"Index", AnimalName}) or {}
	if CurrentEntry.Lucky then return end

	CurrentEntry.Lucky = true
	PlayerChannel:Set({"Index", AnimalName}, CurrentEntry)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)
end

function LuckyBase.OnStart()
	ClaimRemote.OnServerEvent:Connect(function(Player: Player)
		local PlayerChannel = Synchronizer:Get(Player)
		if not PlayerChannel then return end

		if PlayerChannel:Get("UnlockedBaseSkins.Lucky") then return end

		local LuckyIndex = LuckyIndexData.Lucky and LuckyIndexData.Lucky.Index
		if not LuckyIndex then
			NotificationService.Error(Player, "Something went wrong. Please try again.")
			return
		end

		local Collected, Total = SharedIndex:GetIndexAnimals(Player, "Lucky")
		if not Collected or not Total then
			NotificationService.Error(Player, "Something went wrong. Please try again.")
			return
		end

		if Collected < Total then
			NotificationService.Error(Player, string.format("You need all the brainrots! (%d/%d collected)", Collected, Total))
			return
		end

		PlayerChannel:Set("UnlockedBaseSkins.Lucky", true)
		NotificationService.Success(Player, "")
	end)
end

function LuckyBase.OnStop() end
return LuckyBase