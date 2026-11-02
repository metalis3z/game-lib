--!strict

local SettingsService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlotService = require(ServerScriptService.Services.PlotService)
local SkinService = require(ServerScriptService.Services.SkinService)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local BasesData = require(ReplicatedStorage.Datas.Bases)
local SharedGame = require(ReplicatedStorage.Shared.Game)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)

local ToggleSetting = Net:RemoteFunction("SettingsService/ToggleSetting")
local SetFilterBrainrots = Net:RemoteFunction("SettingsService/SetFilterBrainrots")
local lastSkinTime: { [Player]: number } = {}

local ANIMAL_REQUIRED_SKINS = {
	["SmurfCat"] = "Smurf Cat",
	["Strawberry"] = "Strawberry Elephant",
	["Skibidi"] = "Skibidi Toilet",
	["Meowl"] = "Meowl",
	["John Pork"] = "John Pork",
	["Headless"] = "Headless Horseman",
}

function SettingsService:Start()
	task.spawn(function()
		ToggleSetting.OnServerInvoke = function(player: Player, setting: string, new: any): (boolean, string?)
			local playerChannel = Synchronizer:Get(player)
			if not playerChannel then
				return false, "There was an error getting your data. Please rejoin."
			end

			if new == nil then
				local current = playerChannel:Get(string.format("Settings.%s", setting))
				new = not current
			end

			if setting == "Base Skin" then
				local unlockedSkins = playerChannel:Get("UnlockedBaseSkins") or {}
				local skinName = new

				local ownsSkin = unlockedSkins[skinName]
				if not ownsSkin then
					local requiredAnimal = ANIMAL_REQUIRED_SKINS[skinName]
					if requiredAnimal then
						NotificationService.Error(player, string.format("You need a %s to use this base skin!", requiredAnimal))
					else
						NotificationService.Error(player, "You don't own this base skin!")
					end
					return false, "You don't own this base skin!"
				end

				local now = os.clock()
				if lastSkinTime[player] and now - lastSkinTime[player] < 0.5 then
					return true
				end
				lastSkinTime[player] = now

				playerChannel:Set(string.format("Settings.%s", setting), new)

				local plot = PlotService.getPlot(player)
				if plot then
					task.spawn(function()
						SkinService:Apply(new, plot, playerChannel:Get("Rebirth"))
					end)
				end
			elseif setting == "Receive Trades from" then
				if new ~= "Everyone" and new ~= "Friends" and new ~= "No one" then
					return false, "Invalid value for that setting."
				end
				playerChannel:Set(string.format("Settings.%s", setting), new)
			elseif setting == "Only Receive Trades With" then
				playerChannel:Set(string.format("Settings.%s", setting), new == true)
			else
				playerChannel:Set(string.format("Settings.%s", setting), new)
			end

			return true
		end

		SetFilterBrainrots.OnServerInvoke = function(player: Player, list: any): (boolean, string?)
			local playerChannel = Synchronizer:Get(player)
			if not playerChannel then
				return false, "There was an error getting your data. Please rejoin."
			end

			if typeof(list) ~= "table" then
				return false, "Invalid selection."
			end

			local set = {}
			local count = 0
			for _, index in list do
				if typeof(index) == "string" and AnimalsData[index] ~= nil and not set[index] then
					set[index] = true
					count += 1
					if count >= 300 then break end
				end
			end

			playerChannel:Set("TradeFilterBrainrots", set)
			return true
		end
	end)
end

return SettingsService
