local SettingsService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlotService = require(ServerScriptService.Services.PlotService)
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local BasesData = require(ReplicatedStorage.Datas.Bases)
local SharedGame = require(ReplicatedStorage.Shared.Game)

local ToggleSetting = Net:RemoteFunction("SettingsService/ToggleSetting")

local lastSkinTime = {}

ToggleSetting.OnServerInvoke = function(player: Player, setting: string, new: any): (boolean, string?)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return false, "There was an error getting your data, Please rejoin."
	end
	
	if setting == "Base Skin" then
		local currentTime = os.time()

		if lastSkinTime[player] and (currentTime - lastSkinTime[player] < 5) then
			return false, "Hold on! You need to wait a bit before doing that again."
		end
		
		lastSkinTime[player] = currentTime
		
		playerChannel:Set(string.format("Settings.%s", setting), new)

		return true
	end
	
	if new == nil then
		local setting = playerChannel:Get(string.format("Settings.%s", setting))
		new = not setting
	end
	
	playerChannel:Set(string.format("Settings.%s", setting), new)
	
	return true
end

return SettingsService